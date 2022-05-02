import 'dart:developer';
import 'package:http/http.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web3dart/web3dart.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:bip32/bip32.dart' as bip32;
import 'package:web3dart/src/crypto/formatting.dart';

class BlockchainWalletPage extends StatefulWidget {
  const BlockchainWalletPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BlockchainWalletPage();
}

class _BlockchainWalletPage extends State<BlockchainWalletPage> {
  String? _privateKey;
  String? _seedPhrase;
  String? _newWalletSeedPhrase;
  String? _newWalletPrivateKey;
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("how to create blockchain address"),
        ),
        body: ListView(
          children: [
            const SizedBox(
              height: 100,
            ),
            Container(
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.greenAccent),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    labelText: "input your seed phrase",
                    labelStyle: TextStyle(color: Colors.black87),
                    hintStyle: TextStyle(color: Colors.grey),
                    helperText: "helperText 的使用",
                    helperMaxLines: 1,
                    helperStyle: TextStyle(color: Colors.black87),
                    errorMaxLines: 1,
                    filled: true,
                    focusColor: Colors.greenAccent),
                controller: _controller,
                obscureText: false,

                /// 是否是密码
                /// 显示光标
                showCursor: true,
                maxLength: 199,
                onChanged: (v) {
                  setState(() {
                    _seedPhrase = v;
                  });
                },
                onEditingComplete: () {
                  log("textfield ----- onEditingComplete");
                  setState(() {
                    _seedPhrase = _controller.value.text;
                  });
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              child: GestureDetector(
                child: Container(
                  height: 50,
                  width: 100,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: Colors.redAccent,
                  ),
                  child: Text("get private key"),
                ),
                onTap: () {
                  setState(() {
                    log("seed phrase value ---->>>>>$_seedPhrase");
                    if (_seedPhrase != null) {
                      _privateKey = privateKeyFromMnemonic(_seedPhrase!);
                    }
                  });
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                _privateKey ?? "111",
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.grey, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              child: GestureDetector(
                child: Container(
                  height: 50,
                  width: 100,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: Colors.redAccent,
                  ),
                  child: const Text(
                    "create new wallet",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                onTap: ()  async{
                  log("seed phrase value ---->>>>>$_seedPhrase");
                  String randomMnemonic = bip39.generateMnemonic();
                  log("randomMnemonic ---->>>>>>$randomMnemonic");

                  var privateKeyHex = privateKeyFromMnemonic(randomMnemonic);
                  log("mnemonic to privateKey ----> $privateKeyHex");
                  EthPrivateKey key = EthPrivateKey.fromHex(privateKeyHex);
                  EthereumAddress add = await key.extractAddress();
                  log("public key ---- >>>>${add.hex}");

                  setState((){
                    setState(() {
                      _newWalletSeedPhrase = randomMnemonic;
                      _newWalletPrivateKey = privateKeyHex;
                    });
                  });
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                "created new wallet seed phrase -->>> ${_newWalletSeedPhrase}",
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.grey, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                "created new wallet private key -->>> ${_newWalletPrivateKey}",
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.grey, fontWeight: FontWeight.bold),
              ),
            ),
            ElevatedButton(onPressed: () async{
              transfer();
            }, child: Text("转账")),
          ],
          shrinkWrap: true,
        ));
  }

  String privateKeyFromMnemonic(String mnemonic) {
    var seed = bip39.mnemonicToSeed(mnemonic);
    var root = bip32.BIP32.fromSeed(seed);
    var child = root.derivePath("m/44'/60'/0'/0/0");
    var i = child.privateKey;
    log("十进制private key 0----?>>>>$i");
    return bytesToHex(child.privateKey!, include0x: false);
  }

  void transfer() async{
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
            to: EthereumAddress.fromHex(
                '0xcd36f5c3ddc41d06f3c6c4535c14e087e2f7f659'),
            // gasPrice: EtherAmount.inWei(BigInt.one),
            // maxGas: 100000,
            value: EtherAmount.fromUnitAndValue(EtherUnit.finney, 1),
          ),
          chainId: 97
      );
      log("transfer result ---- >> $r");
    }catch(e){
      log("transfer error --->>>>$e");
    }
  }
}
