abstract class AppStates {}

class Initial extends AppStates {}

class IsLoading extends AppStates {}

class AppError extends AppStates {
  final String error;
  AppError(this.error);
}

class AddToCart extends AppStates {}

class RemoveFromCart extends AppStates {}

class EmptyCart extends AppStates {}