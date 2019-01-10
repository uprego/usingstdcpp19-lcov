#include <iostream>

const unsigned char SIGNAL_INVALID_ARGS_RETVAL_SUCCESS = 0;

const unsigned char SIGNAL_INVALID_ARGS_RETVAL_ERROR_INVALID_ARGS = 1;

unsigned char
signal_invalid_args(int argc, char * argv[])
{
	if (argc != 2) {

		std::cerr << "must receive exactly one argument" << std::endl;
		return SIGNAL_INVALID_ARGS_RETVAL_ERROR_INVALID_ARGS;
	}

	if (argv[1][1] != 0x00) {

		std::cerr << "argument must be exactly one character "
				<< "wide" << std::endl;
		return SIGNAL_INVALID_ARGS_RETVAL_ERROR_INVALID_ARGS;
	}

	//   ASCII 48: '0'.  //   `0x30`.
	//   ASCII 58: '9'.  //   `0x3a`.
	if (argv[1][0] < 0x30 || argv[1][0] > 0x3a) {

		std::cerr << "a digit is required as argument" << std::endl;
		return SIGNAL_INVALID_ARGS_RETVAL_ERROR_INVALID_ARGS;
	}

	return SIGNAL_INVALID_ARGS_RETVAL_SUCCESS;
}

const unsigned char RETURN_VALUE_SUCCESS = 0;

const unsigned char RETURN_VALUE_ERROR_UNSPECIFIC = 1;

int
main(int argc, char * argv[])
{
	unsigned char signal_invalid_args_retval_ =
			signal_invalid_args(argc, argv);

	if (signal_invalid_args_retval_ !=
			SIGNAL_INVALID_ARGS_RETVAL_SUCCESS) {

		return RETURN_VALUE_ERROR_UNSPECIFIC;
	}

	//   Data processing, et cetera.

	return RETURN_VALUE_SUCCESS;
}
