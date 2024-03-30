CXX 		:= g++
CXXFLAGS 	:= -g -Werror -Wextra -Wall -pedantic -fstack-protector-all -fsanitize=address
CXXLIB 		:= 
FILE 		:= cpp

SRC_DIR 	= src
BUILD_DIR 	= out
TARGET 		= main

rwildcard = $(foreach d,$(wildcard $(1:=/*)),$(call rwildcard,$d,$2) $(filter $(subst *,%,$2),$d))

SRCS := $(call rwildcard,$(SRC_DIR),*.$(FILE))
OBJS := $(SRCS:$(SRC_DIR)/%.$(FILE)=$(BUILD_DIR)/%.o)

$(TARGET): $(OBJS)
	$(CXX) $(CXXFLAGS) $^ -o $(BUILD_DIR)/$@ $(CXXLIB)

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.cpp | $(BUILD_DIR)
	@mkdir -p  $(shell echo $@ | sed 's/\/[^/]*\..*//g')
	$(CXX) $(CXXFLAGS) -c $< -o $@ $(CXXLIB)

$(BUILD_DIR):
	@mkdir -p $(BUILD_DIR)

clean:
	@rm -rf $(BUILD_DIR)
