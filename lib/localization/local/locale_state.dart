part of 'locale_cubit.dart';

// class ChangeLocaleLoadingState extends LocaleState {
//   const ChangeLocaleLoadingState();
//   @override
//   List<Object?> get props => [];
// }

class ChangeLocaleState extends Equatable {
  final Locale locale;
  const ChangeLocaleState({
    required this.locale,
  });

  @override
  List<Object?> get props => [locale];

  ChangeLocaleState copyWith({
    Locale? locale,
  }) {
    return ChangeLocaleState(
      locale: locale ?? this.locale,
    );
  }
}
