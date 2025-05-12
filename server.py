import http.server
import socketserver
import os

PORT = 5000
DIRECTORY = os.path.join(os.getcwd())

class Handler(http.server.SimpleHTTPRequestHandler):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, directory=DIRECTORY, **kwargs)
    
    def end_headers(self):
        self.send_header('Access-Control-Allow-Origin', '*')
        http.server.SimpleHTTPRequestHandler.end_headers(self)

if __name__ == "__main__":
    print(f"Serving at http://0.0.0.0:{PORT}")
    socketserver.TCPServer.allow_reuse_address = True
    httpd = socketserver.TCPServer(("0.0.0.0", PORT), Handler)
    httpd.serve_forever()