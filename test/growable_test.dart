import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growable/growable.dart';

void main() {
  Widget app(Widget child) => MaterialApp(home: Scaffold(body: ListView(children: [child])));

  testWidgets('expanded text is its own node, not merged into the header', (tester) async {
    final handle = tester.ensureSemantics();
    await tester.pumpWidget(app(GrowableNotifier(
      child: Growable(
        collapsed: Builder(
          builder: (context) => ListTile(
            title: const Text('Privacy'),
            onTap: () => GrowableController.of(context, required: true)?.toggle(),
          ),
        ),
        expanded: const Text('The short version'),
      ),
    )));
    await tester.tap(find.text('Privacy'));
    await tester.pumpAndSettle();

    expect(tester.getSemantics(find.text('Privacy')), matchesSemantics(label: 'Privacy', isButton: true, isFocusable: true, hasTapAction: true, hasFocusAction: true, hasEnabledState: true, isEnabled: true, hasSelectedState: true));
    expect(tester.getSemantics(find.text('The short version')), matchesSemantics(label: 'The short version'));
    handle.dispose();
  });

  testWidgets('GrowableButton says whether it is expanded, and what it does', (tester) async {
    final handle = tester.ensureSemantics();
    final controller = GrowableController(initialExpanded: false);
    await tester.pumpWidget(app(GrowableNotifier(
      controller: controller,
      child: Growable(
        collapsed: GrowableButton(child: GrowableIcon()),
        expanded: const Text('More'),
      ),
    )));
    final button = find.byType(InkWell);
    expect(tester.getSemantics(button), containsSemantics(label: 'Expand', isButton: true, hasExpandedState: true, isExpanded: false));

    controller.toggle();
    await tester.pumpAndSettle();
    expect(tester.getSemantics(button), containsSemantics(label: 'Collapse', isButton: true, hasExpandedState: true, isExpanded: true));
    handle.dispose();
  });

  testWidgets('GrowableButton takes a label', (tester) async {
    final handle = tester.ensureSemantics();
    await tester.pumpWidget(app(GrowableNotifier(
      child: Growable(
        collapsed: GrowableButton(semanticLabel: 'Companion plants', child: GrowableIcon()),
        expanded: const SizedBox(),
      ),
    )));
    expect(tester.getSemantics(find.byType(InkWell)), containsSemantics(label: 'Companion plants\nExpand', isButton: true, isExpanded: false));
    handle.dispose();
  });

  testWidgets("a button over a collapsed preview doesn't make the preview a button", (tester) async {
    final handle = tester.ensureSemantics();
    await tester.pumpWidget(app(GrowableNotifier(
      child: Growable(
        collapsed: Stack(alignment: Alignment.bottomCenter, children: [
          const Column(children: [Text('Aphid midge'), Text('Ladybug'), SizedBox(height: 40)]),
          GrowableButton(child: GrowableIcon()),
        ]),
        expanded: const SizedBox(),
      ),
    )));
    expect(tester.getSemantics(find.text('Ladybug')), isNot(containsSemantics(isButton: true)));
    expect(tester.getSemantics(find.byType(InkWell)), containsSemantics(label: 'Expand', isButton: true, isExpanded: false));
    handle.dispose();
  });
}
