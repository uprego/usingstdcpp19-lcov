#!/bin/sh


CXX='g++'

STANDARD='c++11'


${CXX} --std=${STANDARD} example.cpp -fprofile-arcs -ftest-coverage -o example
