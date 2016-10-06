/*
 * Copyright (C) 2016 The Android Open Source Project
 * Copyright (C) 2016 The CyanogenMod Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include <dlfcn.h>

#include <exception>
#include <sstream>
#include <string>
#include <vector>

#include "utils.h"

using namespace std;

typedef int (*property_set_t)(const char *, const char *);
typedef int (*property_get_t)(const char *, char *, const char *);

static property_get_t __real_property_get;
static property_set_t __real_property_set;

static void init() __attribute__((constructor));

void init() {
    bool haveError = true;
    void *dlHandle;
    if ((dlHandle = dlopen("libcutils.so", RTLD_LAZY))) {
        __real_property_set = (property_set_t) dlsym(dlHandle, "property_set");
        __real_property_get = (property_get_t) dlsym(dlHandle, "property_get");
        if (__real_property_set && __real_property_get) {
            haveError = false;
        }
    }
    if (haveError) {
        throw new exception();
    }
}

static string normalize_key(const char *key) {
    string k(key);
    if (ends_with(k, "_1") || ends_with(k, "_2")) {
        k.erase(k.end() - 2, k.end());
    } else if (ends_with(k, "1") || ends_with(k, "2")) {
        k.erase(k.end() - 1, k.end());
    }
    return k;
}

inline size_t key_slot(const char *key) {
    string k(key);
    return ends_with(k, "_2") || ends_with(k, "2") ? 1 : 0;
}

static vector<string> property_prepare(const char *key) {
    char propVal[91 /* PROPPERTY_VALUE_MAX */];
    vector<string> result;
    size_t slotId = key_slot(key);
    __real_property_get(normalize_key(key).c_str(), propVal, "");
    if ((result = split(propVal, ',')).size() < slotId + 1) {
        for (int i = 1, n = slotId + 1 - result.size(); i <= n; ++i) {
            result.push_back("");
        }
    }
    return result;
}

extern "C" int property_set(const char *key, const char *value) {
    vector<string> values;
    int result = -1;
    if ((values = property_prepare(key)).size()) {
        values[key_slot(key)] = value;
        result = __real_property_set(normalize_key(key).c_str(),
                concat(values, ',').c_str());
    }
    return result;
}

extern "C" int property_get(const char *key, char *value, const char *default_value) {
    vector<string> values;
    int result = 0; // never fail
    if ((values = property_prepare(key)).size()) {
        string &s = values[key_slot(key)];
        result = sprintf(value, "%s", s.empty() ? default_value : s.c_str());
    }
    return result;
}
