import 'package:flutter/material.dart';
import 'package:flutter_messenger/features/auth/views/login.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

Widget _buildTestApp() {
  return MaterialApp.router(
    routerConfig: GoRouter(
      initialLocation: '/login',
      routes: [
        GoRoute(path: '/login', builder: (context, state) => const Login()),
        GoRoute(
          path: '/home',
          builder: (context, state) => const Scaffold(body: Text('Home')),
        ),
      ],
    ),
  );
}

Future<void> pumpLogin(WidgetTester tester) async {
  await tester.pumpWidget(_buildTestApp());
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('hiển thị lỗi khi bấm đăng nhập với form rỗng', (tester) async {
    await pumpLogin(tester);

    await tester.ensureVisible(find.text('Đăng nhập'));
    await tester.tap(find.text('Đăng nhập'));
    await tester.pump();

    expect(find.text('Vui lòng nhập email'), findsOneWidget);
    expect(find.text('Vui lòng nhập mật khẩu'), findsOneWidget);
  });

  testWidgets('báo lỗi khi email không đúng định dạng', (tester) async {
    await pumpLogin(tester);

    await tester.enterText(find.byType(TextFormField).first, 'abc@');
    await tester.ensureVisible(find.text('Đăng nhập'));
    await tester.tap(find.text('Đăng nhập'));
    await tester.pump();

    expect(find.text('Email không hợp lệ'), findsOneWidget);
  });

  testWidgets('báo lỗi khi mật khẩu ngắn hơn 6 ký tự', (tester) async {
    await pumpLogin(tester);

    await tester.enterText(find.byType(TextFormField).first, 'hoang@gmail.com');
    await tester.enterText(find.byType(TextFormField).last, '123');
    await tester.ensureVisible(find.text('Đăng nhập'));
    await tester.tap(find.text('Đăng nhập'));
    await tester.pump();

    expect(find.text('Mật khẩu phải có ít nhất 6 ký tự'), findsOneWidget);
  });

  testWidgets('chuyển sang màn hình home khi nhập dữ liệu hợp lệ', (tester) async {
    await pumpLogin(tester);

    await tester.enterText(find.byType(TextFormField).first, 'hoang@gmail.com');
    await tester.enterText(find.byType(TextFormField).last, '12345678');
    await tester.ensureVisible(find.text('Đăng nhập'));
    await tester.tap(find.text('Đăng nhập'));
    await tester.pumpAndSettle();

    expect(find.text('Email không hợp lệ'), findsNothing);
    expect(find.text('Vui lòng nhập email'), findsNothing);
    expect(find.text('Home'), findsOneWidget);
  });

  testWidgets('toggle hiện/ẩn mật khẩu đổi trạng thái obscureText', (tester) async {
    await pumpLogin(tester);

    final passwordText = find.descendant(
      of: find.byType(TextFormField).last,
      matching: find.byType(EditableText),
    );

    expect(tester.widget<EditableText>(passwordText).obscureText, isTrue);

    await tester.tap(find.byIcon(Icons.visibility_outlined));
    await tester.pump();
    expect(tester.widget<EditableText>(passwordText).obscureText, isFalse);

    await tester.tap(find.byIcon(Icons.visibility_off_outlined));
    await tester.pump();
    expect(tester.widget<EditableText>(passwordText).obscureText, isTrue);
  });
}