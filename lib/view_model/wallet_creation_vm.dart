import 'package:cake_wallet/core/wallet_base.dart';
import 'package:cake_wallet/src/domain/common/wallet_info.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';
import 'package:cake_wallet/core/wallet_credentials.dart';
import 'package:cake_wallet/src/domain/common/wallet_type.dart';
import 'package:cake_wallet/view_model/wallet_creation_state.dart';

part 'wallet_creation_vm.g.dart';

class WalletCreationVM = WalletCreationVMBase with _$WalletCreationVM;

abstract class WalletCreationVMBase with Store {
  WalletCreationVMBase(this._walletInfoSource,
      {@required this.type, @required this.isRecovery}) {
    state = InitialWalletCreationState();
    name = '';
  }

  @observable
  String name;

  @observable
  WalletCreationState state;

  final WalletType type;

  final bool isRecovery;

  final Box<WalletInfo> _walletInfoSource;

  Future<void> create({dynamic options}) async {
    try {
      state = WalletCreating();
      final credentials = getCredentials(options);
      final walletInfo = WalletInfo.external(
          id: WalletBase.idFor(name, type),
          name: name,
          type: type,
          isRecovery: isRecovery,
          restoreHeight: credentials.height ?? 0,
          date: DateTime.now());
      credentials.walletInfo = walletInfo;
      await process(credentials);
      await _walletInfoSource.add(walletInfo);
      state = WalletCreatedSuccessfully();
    } catch (e) {
      state = WalletCreationFailure(error: e.toString());
    }
  }

  WalletCredentials getCredentials(dynamic options) =>
      throw UnimplementedError();

  Future<void> process(WalletCredentials credentials) =>
      throw UnimplementedError();
}