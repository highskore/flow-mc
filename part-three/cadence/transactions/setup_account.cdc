import NonFungibleToken from "../contracts/standard/NonFungibleToken.cdc"
import CryptoDudes from "../contracts/Three.cdc"

transaction {

    prepare(signer: AuthAccount) {
        // Return early if the account already has a collection
        if signer.borrow<&CryptoDudes.Collection>(from: /storage/CryptoDudes) != nil {
            return
        }

        // Create a new empty collection
        let collection <- CryptoDudes.createEmptyCollection()

        // save it to the account
        signer.save(<-collection, to: /storage/CryptoDudes)

        // create a public capability for the collection
        signer.link<&{NonFungibleToken.CollectionPublic, CryptoDudes.CryptoDudesCollectionPublic}>(
            /public/CryptoDudes,
            target: /storage/CryptoDudes
        )
    }
}