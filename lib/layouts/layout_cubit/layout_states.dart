abstract class LayoutStates {}

final class InitialLayoutState extends LayoutStates {}


final class ChangeBottomNavIndexState extends LayoutStates {}

// get user data state
final class GetUserDataSuccessState extends LayoutStates {}
final class GetUserDataLoadingState extends LayoutStates {}
final class FailedToGetUserDataState extends LayoutStates {
  String error;
  FailedToGetUserDataState({required this.error});
}

// get banners data state
final class GetBannersDataSuccessState extends LayoutStates {}
final class FailedToGetBannersDataState extends LayoutStates {}

// get catgories data state
final class GetCategoriesDataSuccessState extends LayoutStates {}
final class FailedToGetCategoriesDataState extends LayoutStates {}

// get Product data state
final class GetProductsDataSuccessState extends LayoutStates {}
final class FailedToGetProductsDataState extends LayoutStates {}

// get favorites data state
final class GetFavoritesDataSuccessState extends LayoutStates {}
final class FailedToGetFavoritesDataState extends LayoutStates {}
// add or remove favorites
final class AddOrRemoveFavoritesSuccessState extends LayoutStates {}
final class FailedToAddOrRemoveFavoritesState extends LayoutStates {}

// filter product data state for search in home page
final class FilterProductsSuccessState extends LayoutStates {}
// filter favorite product data state for search in favorite page
final class FilterFavoriteProductsSuccessState extends LayoutStates {}

// get carts data state
final class GetCartsDataSuccessState extends LayoutStates {}
final class FailedToGetCartsDataState extends LayoutStates {}

// add or remove favorites
final class AddOrRemoveCartsSuccessState extends LayoutStates {}
final class FailedToAddOrRemoveCartsState extends LayoutStates {}

// Change password  state
final class ChangePasswordSuccessState extends LayoutStates {}
final class ChangePasswordLoadingState extends LayoutStates {}
final class FailedToChangePasswordWithFailureState extends LayoutStates {
  String error;
  FailedToChangePasswordWithFailureState({required this.error});
}

// update data state
final class UpdateDataSuccessState extends LayoutStates {}
final class UpdateDataLoadingState extends LayoutStates {}
final class FailedToUpdateDataWithFailureState extends LayoutStates {
  String error;
  FailedToUpdateDataWithFailureState({required this.error});
}

final class RefreshLoadingState extends LayoutStates {}

final class RefreshSuccessState extends LayoutStates {}