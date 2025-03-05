class ApiEndpoints {

  static const baseurl ="https://grocery-app-1h07.onrender.com";

  //authentication
  static const createApiKey = "/createApiKey";
  static const signinUrl="/api/user/signIn";
  static const signupUrl='/api/user/signUp';
  
  //admin
  static const adminDasboard="/api/dashboard/adminDashBoardDatas";
  static const allorders="/api/order/listAllOrders";
  static const productRegistration='/api/product/createProduct';
  static const createCategory='/api/category/createCategory';
  static const updateCategory='/api/category/updateACategory/';
  static const deleteCategory='/api/category/deleteACategory/';
  static const porductUpdate='/api/product/updateAProduct/';
  static const deleteProduct='/api/product/deleteAProduct/';
  static const listAllusers='/api/user/listAllUsers';
  static const updateProductImage='/api/product/updateProductImage/';
  static const getInventoryList='/api/product/getProductInventory';
  static const acknowledgeOrder='/api/order/acknowledgeOrder/';
  static const bannerCraetion='/api/dashboard/createBanners';
    static const bannerdelete='/api/dashboard/deleteABanner/';

  //common
  static const listAllCategories='/api/category/listAllCategories';
  static const listAllProducts='/api/product/listAllProducts';
  static const getOrderbyId='/api/order/getAnOrder/';
  static const getOrderbyUserId='/api/order/listAllOrdersByUser/';
  static const foregetpassword='/api/user/resetPassword/';
  static const getAproduct='/api/product/getAProduct/';

 //User
  static const userDasboard='/api/dashboard/userDashBoardDatas';
  static const listproductundercategory='/api/product/listAllProductsUnderACategory/';
  static const searchProduct='/api/product/searchProducts';
  static const placeOrder='/api/order/placeAnOrder';
  static const profileImage='/api/user/profileImage/';
  static const deleteuser='/api/user/deleteAUser/';
  static const updateUser='/api/user/updateAUser/';
  static const cancelOrder = '/api/order/deleteAnOrder/';
  static const updateOrder='/api/order/updateAnOrder/';
 
}