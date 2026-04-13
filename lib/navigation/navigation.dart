import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:issues_app/presentation/screens/issue_details/issue_details_screen.dart';
import 'package:issues_app/presentation/screens/issues/issues_screen.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return IssuesScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'details/:id',
          builder: (BuildContext context, GoRouterState state) {
            final String issueId = state.pathParameters['id']!;
            return IssueDetailsScreen(id: issueId);
          },
        ),
      ],
    ),
  ],
);
