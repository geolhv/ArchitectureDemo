extension Animal {
    static func fixture() -> Self {
        .init(
            name: "Goldfinch Perched ",
            imageUrl: "https://cdn.pixabay.com/photo/2023/02/06/17/12/bird-7772426_1280.jpg",
            characteristic: .bird
        )
    }

    static func fixture() -> [Self] {
        [
            .init(
                name: "Goldfinch Perched ",
                imageUrl: "https://cdn.pixabay.com/photo/2023/02/06/17/12/bird-7772426_1280.jpg",
                characteristic: .bird
            ),
            .init(
                name: "Shark",
                imageUrl: "https://cdn.pixabay.com/photo/2016/03/31/19/02/blacktip-1294753_1280.jpg",
                characteristic: .fish
            ),
            .init(
                name: "Lion",
                imageUrl: "https://cdn.pixabay.com/photo/2023/06/29/10/33/lion-8096155_1280.png",
                characteristic: .mammal
            ),
            .init(
                name: "Orcas",
                imageUrl: "https://cdn.pixabay.com/photo/2023/06/18/21/46/killer-whale-8072814_1280.jpg",
                characteristic: .fish
            ),
            .init(
                name: "Newt",
                imageUrl: "https://cdn.pixabay.com/photo/2022/04/03/09/13/alpine-newt-7108449_1280.jpg",
                characteristic: .amphibian
            ),
            .init(
                name: "Eagle",
                imageUrl: "https://cdn.pixabay.com/photo/2017/06/09/09/39/adler-2386314_1280.jpg",
                characteristic: .bird
            ),
            .init(
                name: "Anaconda",
                imageUrl: "https://cdn.pixabay.com/photo/2018/10/28/07/37/anaconda-3778041_1280.jpg",
                characteristic: .reptile
            ),
            .init(
                name: "Elephant",
                imageUrl: "https://cdn.pixabay.com/photo/2018/11/22/18/17/elephant-3832516_1280.jpg",
                characteristic: .mammal
            ),
            .init(
                name: "Parrot",
                imageUrl: "https://cdn.pixabay.com/photo/2021/05/08/17/05/parrot-6238905_1280.jpg",
                characteristic: .bird
            ),
            .init(
                name: "Frog",
                imageUrl: "https://cdn.pixabay.com/photo/2016/04/17/16/37/frog-1335022_1280.jpg",
                characteristic: .amphibian
            ),
            .init(
                name: "Crocodile",
                imageUrl: "https://cdn.pixabay.com/photo/2016/09/11/01/00/crocodile-1660512_1280.jpg",
                characteristic: .reptile
            )
        ]
    }
}
