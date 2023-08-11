import socket
import ssl
import threading

def handle_client(conn, addr):
    print(f"{addr} connected.")
    try:
        while True:
            command = conn.recv(1024).decode()
            if command == "message":
                message = conn.recv(1024).decode()
                print(f"Client {addr}: {message}")
            elif command == "file":
                file_name = conn.recv(1024).decode()
                file_size = int(conn.recv(1024).decode())
                print(f"Receiving {file_name} from {addr}...")
                with open(file_name, 'wb') as file:
                    file_data = conn.recv(file_size)
                    file.write(file_data)
                print(f"File {file_name} received successfully.")
            elif command == "exit":
                print(f"{addr} disconnected.")
                break
    except Exception as e:
        print(f"An error occurred with {addr}: {e}")
    finally:
        conn.close()

def create_server_socket(host, port, certfile, keyfile):
    context = ssl.create_default_context(ssl.Purpose.CLIENT_AUTH)
    context.load_cert_chain(certfile=certfile, keyfile=keyfile)
    server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server_socket.bind((host, port))
    server_socket.listen(5)
    print("Server is waiting for connections...")
    while True:
        conn, addr = server_socket.accept()
        conn = context.wrap_socket(conn, server_side=True)
        threading.Thread(target=handle_client, args=(conn, addr)).start()

def main():
    host = input("Enter the server host (e.g., localhost): ")
    port = int(input("Enter the server port (e.g., 12345): "))
    certfile = input("Enter the path to the certificate file (e.g., cert.pem): ")
    keyfile = input("Enter the path to the key file (e.g., key.pem): ")

    create_server_socket(host, port, certfile, keyfile)

if __name__ == "__main__":
    main()
