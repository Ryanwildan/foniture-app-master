import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Seven7 Furniture',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (usernameController.text == 'admin' &&
                    passwordController.text == 'admin123') {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChangeNotifierProvider(
                        create: (context) => CartModel(),
                        child: const MainScreen(),
                      ),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Username atau password salah')),
                  );
                }
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    RestaurantMenu(),
    ProfilePage(),
    CartScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seven7 Furniture'),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

class CartModel extends ChangeNotifier {
  List<Map<String, dynamic>> cartItems = [];

  void addToCart(String title, String price) {
    int index = cartItems.indexWhere((item) => item['title'] == title);
    if (index != -1) {
      cartItems[index]['quantity']++;
    } else {
      cartItems.add({'title': title, 'price': price, 'quantity': 1});
    }
    notifyListeners();
  }

  void removeFromCart(String title) {
    int index = cartItems.indexWhere((item) => item['title'] == title);
    if (index != -1) {
      if (cartItems[index]['quantity'] > 1) {
        cartItems[index]['quantity']--;
      } else {
        cartItems.removeAt(index);
      }
      notifyListeners();
    }
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seven7 Profile'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 248, 99, 0),
              Color.fromARGB(255, 255, 255, 255)
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Seven7 Furniture',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const Text(
                'Alamat:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Text(
                'Jl. Andong Kencono, RT.: 10/RW.02, Rw. 3, Pulodarat, Kec. Pecangaan, Kabupaten Jepara, Jawa Tengah 59462',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              const Text(
                'Telepon:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Text(
                '081229895910',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              const Text(
                'Jam Buka:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Text(
                '08:00 - 22:00',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class RestaurantMenu extends StatelessWidget {
  const RestaurantMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartModel = context.watch<CartModel>();

    final List<Map<String, String>> menuItems = [
      {
        'imagePath': 'kursi.png',
        'title': 'Kursi',
        'description': 'Kursi santai.',
        'price': 'Rp. 250.000',
      },
      {
        'imagePath': 'meja1.png',
        'title': 'Meja',
        'description': 'Meja rotan.',
        'price': 'Rp. 500.000',
      },
      {
        'imagePath': 'almari.png',
        'title': 'Almari',
        'description': 'Almari dua sorok',
        'price': 'Rp. 600.000',
      },
      {
        'imagePath': 'kursilengkung.png',
        'title': 'Kursi Lengkung',
        'description': 'Kursi lengkung',
        'price': 'Rp. 700.000',
      },
      {
        'imagePath': 'minisova.png',
        'title': 'Mini Sova',
        'description': 'Brown Mini Sova',
        'price': 'Rp. 400.000',
      },
      {
        'imagePath': 'mejapanjang.png',
        'title': 'Meja Panjang',
        'description': 'Long Table',
        'price': 'Rp. 550.000',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Furniture Items'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue, Colors.black],
          ),
        ),
        child: GridView.builder(
          padding: const EdgeInsets.all(8.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
            childAspectRatio: 2 / 3,
          ),
          itemCount: menuItems.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                cartModel.addToCart(
                  menuItems[index]['title']!,
                  menuItems[index]['price']!,
                );
              },
              child: _buildMenuItem(
                context,
                menuItems[index]['imagePath']!,
                menuItems[index]['title']!,
                menuItems[index]['description']!,
                menuItems[index]['price']!,
                cartModel,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, String imagePath, String title,
      String description, String price, CartModel cartModel) {
    int quantity =
        cartModel.cartItems.indexWhere((item) => item['title'] == title) != -1
            ? cartModel.cartItems
                .firstWhere((item) => item['title'] == title)['quantity']
            : 0;

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(imagePath,
              height: 100, width: double.infinity, fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              description,
              style: const TextStyle(
                  fontSize: 18, color: Color.fromARGB(255, 0, 0, 0)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              price,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: quantity > 0
                    ? () {
                        cartModel.removeFromCart(title);
                      }
                    : null,
              ),
              Text('$quantity'),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  cartModel.addToCart(title, price);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartModel = context.watch<CartModel>();

    int totalPrice = 0;
    for (var item in cartModel.cartItems) {
      int price = int.parse(item['price'].replaceAll(RegExp(r'[^0-9]'), ''));
      int quantity = item['quantity'];
      totalPrice += price * quantity;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang Belanja'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartModel.cartItems.length,
              itemBuilder: (context, index) {
                final item = cartModel.cartItems[index];
                return ListTile(
                  title: Text(item['title']),
                  subtitle: Text('Jumlah: ${item['quantity']}'),
                  trailing: Text(item['price']),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Total: Rp. ${totalPrice.toString()}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: const AssetImage(
                  'logo.jpg'), // Ganti dengan path gambar profile
            ),
            const SizedBox(height: 20),
            const Text(
              'Alamat:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Text(
              'Jl. Andong Kencono, RT.: 10/RW.02, Rw. 3, Pulodarat, Kec. Pecangaan, Kabupaten Jepara, Jawa Tengah 59462',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            const Text(
              'Telepon:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Text(
              '081229895910',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
