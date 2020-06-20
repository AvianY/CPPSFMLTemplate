# tool macros
CC := g++
CCFLAG :=-Iinclude -ISFML-2.5.1/include -std=c++17
DBGFLAG := -g
CCOBJFLAG := $(CCFLAG) -c

# library macros
LDFLAGS=-Wl,-rpath=SFML-2.5.1/lib
LIBS=-LSFML-2.5.1/lib -lsfml-graphics -lsfml-audio -lsfml-window -lsfml-system

# path macros
BIN_PATH := bin
OBJ_PATH := obj
SRC_PATH := src
INC_PATH := include
DBG_PATH := debug
PATHS := $(BIN_PATH) $(OBJ_PATH) $(SRC_PATH) $(INC_PATH) $(DBG_PATH)

# compile macros
TARGET_NAME := main
ifeq ($(OS),Windows_NT)
	TARGET_NAME := $(addsuffix .exe,$(TARGET_NAME))
endif
TARGET := $(BIN_PATH)/$(TARGET_NAME)
TARGET_DEBUG := $(DBG_PATH)/$(TARGET_NAME)
MAIN_SRC := src/main.cc

# src files & obj files
SRC := $(foreach x, $(SRC_PATH), $(wildcard $(addprefix $(x)/*,.c*)))
INC := $(wildcard $(INC_PATH)/*.h)
OBJ := $(addprefix $(OBJ_PATH)/, $(addsuffix .o, $(notdir $(basename $(SRC)))))
OBJ_DEBUG := $(addprefix $(DBG_PATH)/, $(addsuffix .o, $(notdir $(basename $(SRC)))))

# clean files list
DISTCLEAN_LIST := $(OBJ) \
                  $(OBJ_DEBUG)
CLEAN_LIST := $(TARGET) \
			  $(TARGET_DEBUG) \
			  $(DISTCLEAN_LIST)

# default rule
default: all

# non-phony targets
$(TARGET): $(OBJ) | $(BIN_PATH)
	$(CC) $(CCFLAG) ${LDFLAGS} $(LIBS)  -o $@ $?

$(OBJ): $(SRC) $(INC) | $(OBJ_PATH)
	$(CC) $(CCOBJFLAG) ${LDFLAGS} $(LIBS) -o $@ $<

$(OBJ_DEBUG): $(SRC) | $(DBG_PATH)
	$(CC) $(CCOBJFLAG) $(DBGFLAG) ${LDFLAGS} $(LIBS) -o $@ $<

$(TARGET_DEBUG): $(OBJ_DEBUG)
	$(CC) $(CCFLAG) $(DBGFLAG) ${LDFLAGS} $(LIBS) $? -o $@

# phony rules
.PHONY: all
all: $(TARGET)

.PHONY: debug
debug: $(TARGET_DEBUG)

.PHONY: clean
clean:
	@echo CLEAN $(CLEAN_LIST)
	@rm -f $(CLEAN_LIST)

.PHONY: distclean
distclean:
	@echo CLEAN $(CLEAN_LIST)
	@rm -f $(DISTCLEAN_LIST)