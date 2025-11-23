import CryptoKit
import Foundation

@propertyWrapper
public struct JSON<T: Decodable> {
	public var wrappedValue: T { value }
	private var value: T

    public init(name: String, key: String? = nil, extension: String = "json", bundle: Bundle = .main) {
        if let url = bundle.url(forResource: name, withExtension: `extension`) {
            if let key {
                value = try! JSONDecoder().decode(T.self, from: Self.decrypt(url, key: key))
            } else {
                value = try! JSONDecoder().decode(T.self, from: Data(contentsOf: url))
            }
		} else {
			fatalError()
		}
	}

	private static func decrypt(_ url: URL, key: String) -> Data {
		guard
			let encryptedData = try? Data(contentsOf: url),
			let keyData = Data(base64Encoded: key) else {
			fatalError("App cannot start if decryption fails")
		}
		let key = SymmetricKey(data: keyData)
		do {
			let sealedBox = try AES.GCM.SealedBox(combined: encryptedData)
			let decryptedData = try AES.GCM.open(sealedBox, using: key)
			return decryptedData
		} catch {
			fatalError("App cannot start if decryption fails")
		}
	}
}
