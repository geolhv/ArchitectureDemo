import Factory

public extension Container {
    var networkClient: Factory<NetworkingClientRequestable> {
        Factory(self) {
            NetworkingClient()
        }
    }
}
