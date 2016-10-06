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

#include "utils.h"

vector<string> split(const string &s, char delim) {
    vector<string> result;
    stringstream ss;
    ss.str(s);
    string item;
    while (getline(ss, item, delim)) {
        result.push_back(item);
    }
    return result;
}

string concat(const vector<string> &v, char delim) {
    if (v.size()) {
        string s = *v.begin();
        for (vector<string>::const_iterator i = v.begin() + 1; i != v.end(); ++i) {
            s += delim;
            s += *i;
        }
        return s;
    }
    return string("");
}

bool ends_with(string const &value, string const &ending) {
    return ending.size() > value.size()
            ? false
            : equal(ending.rbegin(), ending.rend(), value.rbegin());
}
