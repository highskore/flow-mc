import NonFungibleToken from "../contracts/standard/NonFungibleToken.cdc"
import CryptoDudes from "../contracts/Three.cdc"

pub fun main(address: Address, id: UInt64): {String: AnyStruct} {

    let owner = getAccount(address)

    let collectionBorrow = owner.getCapability(/public/CryptoDudes)
        .borrow<&{CryptoDudes.CryptoDudesCollectionPublic}>()
        ?? panic("Could not borrow CryptoDudesCollectionPublic")

    let nft = collectionBorrow.borrowAuthNFT(id: id)
        ?? panic("No such id in that collection")

    return {
        "name": nft.name,
        "favouriteFood": nft.favouriteFood,
        "luckyNumber": nft.luckyNumber
    }
}