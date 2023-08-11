import socket
import ssl

def send_file(conn, file_path):
    with open(file_path, 'rb') as file:
        file_data = file.read()
        conn.sendall("file".encode())
        conn.sendall(file_path.encode())
        conn.sendall(str(len(file_data)).encode())
        conn.sendall(file_data)
        print(f"File {file_path} sent successfully.")

def main():
    host = input("Enter the server host (e.g., localhost): ")
    port = int(input("Enter the server port (e.g., 12345): "))
    context = ssl.create_default_context()
    conn = socket.create_connection((host, port))
    conn = context.wrap_socket(conn, server_hostname=host)

    try:
        while True:
            choice = input("Send message or file? (m/f/exit): ")
            if choice.lower() == 'm':
                message = input("Message: ")
                conn.sendall("message".encode())
                conn.sendall(message.encode())
            elif choice.lower() == 'f':
                file_path = input("Enter the path to the file: ")
                send_file(conn, file_path)
            elif choice.lower() == 'exit':
                conn.sendall("exit".encode())
                print("Exiting...")
                break
            else:
                print("Invalid choice, try again.")
    except KeyboardInterrupt:
        print("\nDisconnecting from the server...")
    except Exception as e:
        print(f"An error occurred: {e}")
    finally:
        conn.close()

if __name__ == "__main__":
    main()
