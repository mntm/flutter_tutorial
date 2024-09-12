import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:catalog_bloc/src/data/repository.dart';
import 'package:equatable/equatable.dart';
import 'package:paint_collection/paint_collection.dart';

part "catalog_event.dart";
part "catalog_state.dart";

class CatalogBloc extends Bloc<CatalogEvent, CatalogState> {
  final Repository repository;

  StreamSubscription<Item>? _subscription;
  CatalogBloc(this.repository) : super(CatalogInitial()) {
    on<CatalogInitiated>(_onCatalogInitiated);
    on<CatalogItemReceived>(_onItemReceived);
    on<CatalogItemCompleted>(_onItemCompleted);
    on<CatalogRefreshRequested>(_onRefresh);
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }

  void _onItemReceived(CatalogItemReceived event, Emitter<CatalogState> emit) {
    repository.addToCatalog(event.item);
    emit(CatalogLoading(List.of(repository.catalogItems)));
  }

  void _onItemCompleted(
      CatalogItemCompleted event, Emitter<CatalogState> emit) {
    emit(CatalogReady(List.of(repository.catalogItems)));
  }

  FutureOr<void> _onCatalogInitiated(
      CatalogInitiated event, Emitter<CatalogState> emit) {
    emit(CatalogInitial());
  }

  FutureOr<void> _onRefresh(
      CatalogRefreshRequested event, Emitter<CatalogState> emit) {
    repository.clearCatalog();
    emit(CatalogLoading(List.of(repository.catalogItems)));
    _subscription?.cancel();
    _subscription = repository.loadCatalog().listen(
      (item) {
        add(
          CatalogItemReceived(item),
        );
      },
    );
    _subscription?.onDone(() {
      add(CatalogItemCompleted());
    });
  }
}
