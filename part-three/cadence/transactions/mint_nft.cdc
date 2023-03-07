
import NonFungibleToken from "../contracts/standard/NonFungibleToken.cdc"
import CryptoDudes from "../contracts/Three.cdc"

transaction(
   name: String, 
   favouriteFood: String, 
   luckyNumber: Int,
   recipient: Address
) {

    /// local variable for storing the minter reference
    let minter: &CryptoDudes.Minter

    /// Reference to the receiver's collection
    let recipientCollectionRef: &{NonFungibleToken.CollectionPublic}

    prepare(signer: AuthAccount) {
        // borrow a reference to the NFTMinter resource in storage
        self.minter = signer.borrow<&CryptoDudes.Minter>(from: /storage/Minter)
            ?? panic("Account does not store an object at the specified path")

        // Borrow the recipient's public NFT collection reference
        self.recipientCollectionRef = getAccount(recipient)
            .getCapability(/public/CryptoDudes)
            .borrow<&{NonFungibleToken.CollectionPublic}>()
            ?? panic("Could not get receiver reference to the NFT Collection")
    }

    execute {
        // Mint the NFT and deposit it to the recipient's collection
        let nft <- self.minter.createNFT(name: name, favouriteFood: favouriteFood, luckyNumber: luckyNumber)
        // Deposit the NFT to the recipient's collection'
        self.recipientCollectionRef.deposit(token: <-nft)
    }
}