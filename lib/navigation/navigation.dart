import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:issues_app/presentation/screens/issue_details.dart';
import 'package:issues_app/presentation/screens/issues.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return Issues();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'details/:id',
          builder: (BuildContext context, GoRouterState state) {
            final String issueId = state.pathParameters['id']!;
            return IssueDetails(id: issueId);
          },
        ),
      ],
    ),
  ],
);
