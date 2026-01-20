import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hockey_app/services/firestore_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = FirestoreService();

  // Stream para escuchar cambios de estado (Login/Logout)
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Obtener usuario actual
  User? get currentUser => _auth.currentUser;

  // Iniciar sesión con Email y Password
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  // Registrar usuario con Email y Password
  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    UserCredential credential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    //guardamos la respuesta en credential y si es correcta guardamos el usuario en firestore
    if (credential.user != null) {
      await _firestoreService.saveUser(credential.user!.uid, email);
    }
  }

  //iniciar sesion con google
  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        return null;
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final userCredential = await _auth.signInWithCredential(credential);

      // Guardar usuario en Firestore si es nuevo
      if (userCredential.additionalUserInfo?.isNewUser == true &&
          userCredential.user != null) {
        await _firestoreService.saveUser(
          userCredential.user!.uid,
          userCredential.user!.email ?? '',
        );
      }

      return userCredential.user;
    } catch (e) {
      rethrow;
    }
  }

  // Cerrar sesión
  Future<void> signOut() async {
    await GoogleSignIn().signOut();
    await _auth.signOut();
  }
}
