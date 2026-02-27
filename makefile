#Set this to @ to keep the makefile quiet
SILENCE = @

#---- Outputs ----#
COMPONENT_NAME = your

#--- Inputs ----#
PROJECT_HOME_DIR = .
ifeq "$(CPPUTEST_HOME)" ""
	$(error The environment variable CPPUTEST_HOME is not set. \
	Set it to where cpputest is installed)
endif

# --- SRC_FILES and SRC_DIRS ---
# Production code files are compiled and put into
# a library to link with the test runner.
#
# Test code of the same name overrides
# production code at link time.
#
# SRC_FILES specifies individual production
# code files.
#
# SRC_DIRS specifies directories containing
# production code C and CPP files.
#
SRC_FILES += src/Example.c
SRC_FILES += src/LedDriver.c
SRC_DIRS += platform

# --- TEST_SRC_FILES and TEST_SRC_DIRS ---
# Test files are always included in the build.
# Production code is pulled into the build unless
# it is overridden by code of the same name in the
# test code.
#
# TEST_SRC_FILES specifies individual test files to build.
# TEST_SRC_DIRS, builds everything in the directory

TEST_SRC_FILES +=
TEST_SRC_DIRS += tests
TEST_SRC_DIRS += tests/io-cppumock
TEST_SRC_DIRS += tests/printf-spy

#	tests/fff \
#	tests/fff \

# --- MOCKS_SRC_DIRS ---
# MOCKS_SRC_DIRS specifies a directories where you can put your
# mocks, stubs and fakes.  You can also just put them
# in TEST_SRC_DIRS
MOCKS_SRC_DIRS +=

# Turn on CppUMock
CPPUTEST_USE_EXTENSIONS = Y

# INCLUDE_DIRS are searched in order after the included file's
# containing directory
INCLUDE_DIRS += $(CPPUTEST_HOME)/include
INCLUDE_DIRS += $(CPPUTEST_HOME)/include/Platforms/Gcc
INCLUDE_DIRS += include
INCLUDE_DIRS += fff
INCLUDE_DIRS += tests/exploding-fakes
INCLUDE_DIRS += tests/fff


# --- CPPUTEST_OBJS_DIR ---
# CPPUTEST_OBJS_DIR lets you control where the
# build artifact (.o and .d) files are stored.
#
# If you have to use "../" to get to your source path
# the makefile will put the .o and .d files in surprising
# places.
#
# To make up for each level of "../"in the source path,
# add place holder subdirectories to CPPUTEST_OBJS_DIR
# each.
# e.g. if you have "../../src", set to "test-objs/1/2"
#
# This is kind of a kludge, but it causes the
# .o and .d files to be put under objs.
CPPUTEST_OBJS_DIR = test-obj

CPPUTEST_LIB_DIR = test-lib

# You may have to tweak these compiler flags
#    CPPUTEST_WARNING_FLAGS - apply to C and C++
#    CPPUTEST_C_FLAGS - apply to C files only
#    CPPUTEST_CXX_FLAGS - apply to C++ files only
#    CPPUTEST_CPPFLAGS - apply to C and C++ Pre-Processor
#
# If you get an error like this
#     TestPlugin.h:93:59: error: 'override' keyword is incompatible
#        with C++98 [-Werror,-Wc++98-compat] ...
# The compiler is basically telling you how to fix the
# build problem.  You would add this flag setting
#     CPPUTEST_CXX_FLAGS += -Wno-c++14-compat




# Some flags to quiet clang
ifeq ($(shell $(CC) -v 2>&1 | grep -c "clang"), 1)
	CPPUTEST_WARNING_FLAGS += -Wno-unknown-warning-option
	CPPUTEST_WARNING_FLAGS += -Wno-covered-switch-default
	CPPUTEST_WARNING_FLAGS += -Wno-reserved-id-macro
	CPPUTEST_WARNING_FLAGS += -Wno-keyword-macro
	CPPUTEST_WARNING_FLAGS += -Wno-documentation
	CPPUTEST_WARNING_FLAGS += -Wno-missing-noreturn
endif

CPPUTEST_WARNING_FLAGS += -Wall
CPPUTEST_WARNING_FLAGS += -Werror
CPPUTEST_WARNING_FLAGS += -Wfatal-errors
CPPUTEST_WARNING_FLAGS += -Wswitch-default
CPPUTEST_WARNING_FLAGS += -Wno-format-nonliteral
CPPUTEST_WARNING_FLAGS += -Wno-sign-conversion
CPPUTEST_WARNING_FLAGS += -Wno-pedantic
CPPUTEST_WARNING_FLAGS += -Wno-shadow
CPPUTEST_WARNING_FLAGS += -Wno-missing-field-initializers
CPPUTEST_WARNING_FLAGS += -Wno-unused-parameter

CPPUTEST_C_FLAGS += -pedantic
CPPUTEST_C_FLAGS += -Wno-missing-prototypes
CPPUTEST_C_FLAGS += -Wno-strict-prototypes

CPPUTEST_CXX_FLAGS += -Wno-c++14-compat
CPPUTEST_CXX_FLAGS += --std=c++11
CPPUTEST_CXX_FLAGS += -Wno-c++98-compat-pedantic
CPPUTEST_CXX_FLAGS += -Wno-c++98-compat

# Colorise output
CPPUTEST_EXE_FLAGS += -c

# --- LD_LIBRARIES -- Additional needed libraries can be added here.
# commented out example specifies math library
#LD_LIBRARIES += -lm

# Look at $(CPPUTEST_HOME)/build/MakefileWorker.mk for more controls

include $(CPPUTEST_HOME)/build/MakefileWorker.mk
