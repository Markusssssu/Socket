
CC = gcc

CFLAGS = -IInclude -Wall -Wextra -g

SRC_DIR = src
SRC_FILES = $(SRC_DIR)/server.c $(SRC_DIR)/client.c

OBJ_DIR = obj
OBJ_FILES = $(OBJ_DIR)/server.o $(OBJ_DIR)/client.o

SERVER_TARGET = server
CLIENT_TARGET = client

all: $(SERVER_TARGET) $(CLIENT_TARGET)


$(SERVER_TARGET): $(OBJ_DIR)/server.o
	$(CC) $(CFLAGS) -o $(SERVER_TARGET) $(OBJ_DIR)/server.o


$(CLIENT_TARGET): $(OBJ_DIR)/client.o
	$(CC) $(CFLAGS) -o $(CLIENT_TARGET) $(OBJ_DIR)/client.o


$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	@mkdir -p $(OBJ_DIR)
	$(CC) $(CFLAGS) -c $< -o $@


clean:
	rm -rf $(OBJ_DIR) $(SERVER_TARGET) $(CLIENT_TARGET)


run_server: $(SERVER_TARGET)
	./$(SERVER_TARGET)


run_client: $(CLIENT_TARGET)
	./$(CLIENT_TARGET)


run: $(SERVER_TARGET) $(CLIENT_TARGET)
	@echo "Запуск сервера..."
	@sleep 2  # Даем серверу время на запуск
	@echo "Запуск клиента..."

.PHONY: all clean run_server run_client run
