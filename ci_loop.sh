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
# ci.sh: Super simple tests runner.
#


FORCE=0

BASE='/var/www/html/lcov/github/uprego'

ORIGINAL_BRANCH=`git branch | grep '*' | cut -d ' ' -f 2`


if test $# -eq 1
then
	if test "$1" = '--force'
	then
		FORCE=1
	fi
fi

current_hash=`nice -n 19 git log --pretty=%H | head -1`

until false
do
for branch in step0 step1
do
	previous_hash=${current_hash} &&
			nice -n 19 git fetch origin &&
			nice -n 19 git checkout ${branch} &&
			nice -n 19 git reset --hard origin/${branch} &&
			current_hash=`nice -n 19 git log --pretty=%H | head -1`
	if test ${previous_hash} != ${current_hash} \
			-o ! -d ${BASE}/usingstdcpp19-lcov/${branch}/ \
			-o ${FORCE} -eq 1
	then
		true &&
				FORCE=0 &&
				nice -n 19 rm -fv `find ./ | grep gcno$` &&
				nice -n 19 rm -fv `find ./ | grep gcda$` &&
				nice -n 19 ./build.sh &&
				figlet 'successfully built'

		#   Run external controlled test cases - necessary for
		# some tests like external arguments provisioning.
		true &&
				./run_cases.sh &&
				figlet 'successfully ran tests'

		#   Generate the coverage reports.
		true &&
				#   Removed the `gcov` call because it seemed
				# to break the `lcov` branch coverage report.
				# nice -n 19 gcov \
				# 		--branch-probabilities \
				# 		`find ./ | grep gcda` &&
				nice -n 19 rm -fv lcov.info &&
				rm -rfv `find ./ | grep lcov.info`
				nice -n 19 lcov \
						--capture \
						--no-external \
						--rc lcov_branch_coverage=1 \
						--directory ./ \
						--output lcov.info &&
				rm -rfv ./gcov_results/ &&
				#   I still don't understand what is the
				# difference in using `--show-details` in
				# `genhtml`, or not to use it, so I leave it
				# out for now.
				#   Can not use `--frames` in `genhtml` because
				# it seems to break branches coverage.
				#   Branches coverage is added with
				#  `--branch-coverage`.
				nice -n 19 genhtml \
						--frames \
						--title 'usingstdcpp19-lcov' \
						--precision 2 \
						--output-directory \
								./gcov_results/ \
						lcov.info &&

				#   Dark orange in details changed to
				# light red.
				sed 's/FF6230/F99F99/g' ./gcov_results/gcov.css | \
						#   Blue in details
						# changed to light green.
						sed 's/CAD7FE/B4E8A7/g' | \
						#   Change the green
						# in summaries.
						sed 's/A7FC9D/66EE44/g' | \
						#   Changed the yellow
						# in summaries.
						sed 's/FFEA20/FFD942/g' | \
						#   Change the red in
						# summaries.
						sed 's/FF0000/FF4242/g' | \
						sponge ./gcov_results/gcov.css &&

				cp ./misc/emerald.png ./gcov_results/emerald.png &&
				cp ./misc/ruby.png ./gcov_results/ruby.png &&
				cp ./misc/amber.png ./gcov_results/amber.png &&

				true &&

				sudo rm -rfv ${BASE}/usingstdcpp19-lcov/${branch}/ &&
				sudo cp -rfv ./gcov_results/ \
						${BASE}/usingstdcpp19-lcov/${branch}/ &&
				(figlet -w `tput cols` succeeded ${branch} &&
						sleep 1) ||
					(true &&
							sudo rm -rfv ${BASE}/usingstdcpp19-lcov/${branch}/ &&
							sudo mkdir ${BASE}/usingstdcpp19-lcov/${branch}/ &&
							touch ./index.html &&
							echo 'the build failed' >>./index.html &&
							sudo mv ./index.html ${BASE}/usingstdcpp19-lcov/${branch}/index.html
							figlet -w `tput cols` failed ${branch} &&
							sleep 1)

	fi
done
nice -n 19 git checkout ${ORIGINAL_BRANCH}
date
echo 'sleep 300...'
sleep 300
done
