import 'dart:developer' as dev;
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:magic_sdk/magic_sdk.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web3dart/src/crypto/formatting.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:bip32/bip32.dart' as bip32;

class MagicWalletPage extends StatefulWidget {
  const MagicWalletPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MagicWalletPageState();
}

class _MagicWalletPageState extends State<MagicWalletPage> {
  Magic magic = Magic.instance;

  final myController = TextEditingController(text: 'jerry@magic.link');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Magic Demo dev.login'),
          automaticallyImplyLeading: false,
        ),
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: TextFormField(
              controller: myController,
              decoration: const InputDecoration(
                hintText: 'Enter your email',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
            ),
          ),
          TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            ),
            onPressed: () async {
              dev.log("123");
              var token =
                  await magic.auth.loginWithMagicLink(email: myController.text);
              dev.log('token, $token');

              if (token.isNotEmpty) {
                /// Navigate to home page
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => const HomePage()));
              }
            },
            child: const Text('login With Magic Link'),
          ),
          TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            ),
            onPressed: () async {
              const rpcUrl = 'https://data-seed-prebsc-1-s1.binance.org:8545/';

              /// wallet client:
              // var client = EthWallet(url: rpcUrl);
              var httpClient = Client();
              var ethClient = Web3Client(rpcUrl, httpClient);
              String a = "0x820d7173153b39ee9324b1f83584ba392c1bc6803b1b15497f9367e13f67403f";
              try {

                EthPrivateKey credentials = await ethClient.credentialsFromPrivateKey(a);
                EtherAmount balance = await ethClient.getBalance(credentials.address);
                dev.log("balance --->>>>${balance.getValueInUnit(EtherUnit.ether)}");
              } catch (e) {
                dev.log("error --->$e");
              }
            },
            child: const Text('Check balance'),
          ),
          TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            ),
            onPressed: () async {
              const rpcUrl = 'https://data-seed-prebsc-1-s1.binance.org:8545/';

              /// wallet client:
              var httpClient = Client();
              var ethClient = Web3Client(rpcUrl, httpClient);
              String a = "0x820d7173153b39ee9324b1f83584ba392c1bc6803b1b15497f9367e13f67403f";
              try {

                var credentials = await ethClient.credentialsFromPrivateKey(a);

                var r = await ethClient.sendTransaction(
                  credentials,
                  Transaction(
                    to: EthereumAddress.fromHex('0xcd36f5c3ddc41d06f3c6c4535c14e087e2f7f659'),
                    // gasPrice: EtherAmount.inWei(BigInt.one),
                    // maxGas: 100000,
                    value: EtherAmount.fromUnitAndValue(EtherUnit.finney, 1),
                  ),
                  chainId: 97
                );
                dev.log("balance --->>>>${r}");
              } catch (e) {
                dev.log("error --->$e");
              }
            },
            child: const Text('Check balance'),
          ),
          TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            ),
            onPressed: () async {
              const rpcUrl = 'https://data-seed-prebsc-1-s1.binance.org:8545/';

              /// wallet client:
              var httpClient = Client();
              var ethClient = Web3Client(rpcUrl, httpClient);
              String a = "0x820d7173153b39ee9324b1f83584ba392c1bc6803b1b15497f9367e13f67403f";
              try {

                var rng = Random.secure();
                EthPrivateKey random = EthPrivateKey.createRandom(rng);
                EthereumAddress add = await random.extractAddress();
                var s = EthPrivateKey.fromHex(add.hex);

                dev.log("address --->>>>${add.hex} private key -----${bytesToHex(random.privateKey,include0x:true)}");
              } catch (e) {
                dev.log("error --->$e");
              }
            },
            child: const Text('Create Wallet Address'),
          ),
          TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            ),
            onPressed: () async {
              const rpcUrl = 'https://data-seed-prebsc-1-s1.binance.org:8545/';

              /// wallet client:
              var httpClient = Client();
              var ethClient = Web3Client(rpcUrl, httpClient);
              String a = "0x820d7173153b39ee9324b1f83584ba392c1bc6803b1b15497f9367e13f67403f";
              try {

                // uses HEX strings for entropy
                // String randomMnemonic =  bip39.generateMnemonic();
                // String randomMnemonic = "supply season come scare top lobster cereal multiply lamp narrow job manage";
                String randomMnemonic = "chuckle just hard answer tongue dumb whisper crush toe chair rebel drift";
                dev.log("randomMnemonic ---->>>>>>$randomMnemonic");


                var privateKeyHex = privateKeyFromMnemonic(randomMnemonic);
                dev.log("mnemonic to privateKey ----> $privateKeyHex");
                // 0x820d7173153b39ee9324b1f83584ba392c1bc6803b1b15497f9367e13f67403f

                bool isValid =  bip39.validateMnemonic(randomMnemonic);
                dev.log("isValid ---->>>>>>$isValid");
                // => true

                // generate a new key randomly
                var random = Random.secure();
                // create new wallet from a private key
                Wallet newWallet = Wallet.createNew(EthPrivateKey.fromHex(privateKeyHex), "password", random);
                // unlock wallet by password
                Wallet wallet = Wallet.fromJson(newWallet.toJson(), "password");
                // get wallet privateKey to use for credentials/transactions
                Credentials unlockedCredentials = wallet.privateKey;
                EthPrivateKey unlockedPrivateKey = wallet.privateKey;

                String r = bytesToHex(unlockedPrivateKey.privateKey, include0x:true);
                dev.log("new wallet ---- ${newWallet.toJson()}");
                dev.log("unlocked private key ---- $r");

                //dev.log("entropy---->>>>$entropy   seed ----->>>>$seed  randomMnemonic ------>>>>$randomMnemonic  mnemonic---->>>$mnemonic" );


              } catch (e) {
                dev.log("error --->$e");
              }
            },
            child: const Text('Create  Word List'),
          ),
        ])));
  }

  String privateKeyFromMnemonic(String mnemonic) {
    var seed = bip39.mnemonicToSeed(mnemonic);
    var root = bip32.BIP32.fromSeed(seed);
    var child = root.derivePath("m/44'/60'/0'/0/0");
    return bytesToHex(child.privateKey!, include0x: true);
  }
}
