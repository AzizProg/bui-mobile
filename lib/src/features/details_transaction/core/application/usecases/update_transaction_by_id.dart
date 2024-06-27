import 'package:dartz/dartz.dart';
import 'package:test_mobile/src/features/dashboard/core/domain/entities/transaction_entity.dart';
import 'package:test_mobile/src/features/details_transaction/core/domain/ports/details_transaction_repository.dart';

import '../../../../../shared/errors/failure.dart';

class UpdateTransactionById {
  UpdateTransactionById({required this.detailsTransactionRepository});
  IDetailsTransactionRepository detailsTransactionRepository;

  Future<UpdateTransactionByIdResponse> call(int id,String description) async {
    return await this.detailsTransactionRepository.updateTransactionById(id,description);
  }
}
