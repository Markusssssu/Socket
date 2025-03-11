# Компилятор
CC = gcc

# Флаги компиляции
CFLAGS = -IInclude -Wall -Wextra -g

# Исходные файлы
SRC_DIR = src
SRC_FILES = $(SRC_DIR)/server.c $(SRC_DIR)/client.c

# Объектные файлы
OBJ_DIR = obj
OBJ_FILES = $(OBJ_DIR)/server.o $(OBJ_DIR)/client.o

# Имена исполняемых файлов
SERVER_TARGET = server
CLIENT_TARGET = client

# Правило по умолчанию
all: $(SERVER_TARGET) $(CLIENT_TARGET)

# Сборка сервера
$(SERVER_TARGET): $(OBJ_DIR)/server.o
	$(CC) $(CFLAGS) -o $(SERVER_TARGET) $(OBJ_DIR)/server.o

# Сборка клиента
$(CLIENT_TARGET): $(OBJ_DIR)/client.o
	$(CC) $(CFLAGS) -o $(CLIENT_TARGET) $(OBJ_DIR)/client.o

# Компиляция объектных файлов
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	@mkdir -p $(OBJ_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

# Очистка
clean:
	rm -rf $(OBJ_DIR) $(SERVER_TARGET) $(CLIENT_TARGET)

# Запуск сервера
run_server: $(SERVER_TARGET)
	./$(SERVER_TARGET)

# Запуск клиента
run_client: $(CLIENT_TARGET)
	./$(CLIENT_TARGET)

# Запуск сервера и клиента в разных терминалах (для Linux/MacOS)
run: $(SERVER_TARGET) $(CLIENT_TARGET)
	@echo "Запуск сервера..."
	@sleep 2  # Даем серверу время на запуск
	@echo "Запуск клиента..."

.PHONY: all clean run_server run_client run
