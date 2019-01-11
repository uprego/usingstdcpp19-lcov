#!/bin/sh

#
# Copyright 2019 uprego (uprego@outlook.com)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# build.sh: Super simple non GNU Make build script.
#


CXX='g++'

STANDARD='c++11'

CXX_COVERAGE_FLAGS='-fprofile-arcs -ftest-coverage'

CXX_EXCEPTIONS_FLAG='-fno-exceptions'

${CXX} \
		--std=${STANDARD} \
		example.cpp \
		${CXX_COVERAGE_FLAGS} \
		${CXX_EXCEPTIONS_FLAG} \
		-o example
