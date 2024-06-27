import 'package:test_mobile/src/features/details_transaction/core/domain/ports/details_transaction_repository.dart';

class GetTransactionByIdUsecase {
  GetTransactionByIdUsecase({required this.detailsTransactionRepository});
  IDetailsTransactionRepository detailsTransactionRepository;

  Future<GetTransactionByIdResponse> call(int id) async {
    return await this.detailsTransactionRepository.getTransactionById(id);
  }
}
