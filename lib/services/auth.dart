import 'package:firebase_auth/firebase_auth.dart';
import 'package:wallpapernest/models/user.dart';
import 'package:wallpapernest/screens/widgets/placeholder_toast.dart';
import 'package:wallpapernest/services/database.dart';

class AuthService{
  final _auth = FirebaseAuth.instance;

  CustomUser? _userFromFirebaseUser(User? user){
    return user!=null ? CustomUser(uid: user.uid,email: user.email.toString(), userName: '', likedWallpapers: [], downloadedWallpapers: []):null;
  }


  // Auth Change User Stream
  Stream<CustomUser?> get getUser{
    return _auth.authStateChanges().map((User? user) => _userFromFirebaseUser(user));
  }


  // Register New User
  Future<void> registerUser(String email,String password,String retypedPassword,String userName)async{
    if(email.isEmpty || userName.isEmpty || password.isEmpty || retypedPassword.isEmpty){
      showToast('Enter valid non-empty credentials');
    }else if(password.compareTo(retypedPassword)!=0){
      showToast('Password and Retyped Password must be same');
    }else{
      try{
        _auth.createUserWithEmailAndPassword(email: email, password: password).then((val)async{
          await DatabaseService(uid: val.user!.uid).updateUserData(CustomUser(uid: val.user!.uid, email: email, userName: userName, likedWallpapers: [], downloadedWallpapers: [])).then((value){
            showToast('User registered successfully!');
          },onError: (e){showToast(e.toString());});
        },onError: (e){showToast(e.toString());});

      }catch(e){
        showToast(e.toString());
      }
    }
  }

  // Login User
  Future<void> loginUser(String email,String password)async{
    if(email.isEmpty || password.isEmpty){
      showToast('Enter valid non-empty credentials');
    }else{
      try{
        _auth.signInWithEmailAndPassword(email: email, password: password).then((user){
          showToast('Logged in successfully!');
        },onError: (e){showToast(e.toString());});
      }catch(e){
        showToast(e.toString());
      }
    }
  }

  // Sign Out
  Future<void> signOut()async{
    await _auth.signOut();
  }

}