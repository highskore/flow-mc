import NonFungibleToken from "../contracts/standard/NonFungibleToken.cdc"
import CryptoDudes from "../contracts/Three.cdc"

pub fun main(address: Address): [UInt64] {

    let owner = getAccount(address)

    let collectionBorrow = owner.getCapability(/public/CryptoDudes)
        .borrow<&{CryptoDudes.CryptoDudesCollectionPublic}>()
        ?? panic("Could not borrow CryptoDudesCollectionPublic")

    return collectionBorrow.getIDs()
}