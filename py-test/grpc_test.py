import grpc

def ping_grpc_server(target='report-service', timeout=5):
    credentials = grpc.ssl_channel_credentials()
    channel = grpc.secure_channel(target, credentials)

    try:
        grpc.channel_ready_future(channel).result(timeout=timeout)
        print(f"✅ Successfully connected to gRPC server at {target}")
    except grpc.FutureTimeoutError:
        print(f"❌ Timeout: Could not connect to gRPC server at {target}")
    finally:
        channel.close()

if __name__ == '__main__':
    ping_grpc_server(target='127.0.0.1:9001')
    ping_grpc_server(target='common-service') # common service
    ping_grpc_server() # report service
