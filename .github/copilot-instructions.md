<!-- Use this file to provide workspace-specific custom instructions to Copilot. For more details, visit https://code.visualstudio.com/docs/copilot/copilot-customization#_use-a-githubcopilotinstructionsmd-file -->

# Flutter App Development Instructions

This is a Flutter mobile application project with Firebase integration. When working on this codebase:

## General Guidelines
- Follow Flutter best practices and conventions
- Use Material Design 3 components when possible
- Implement responsive design principles
- Follow Dart style guide conventions
- Use proper state management patterns (Provider, Riverpod, or BLoC as appropriate)

## Firebase Integration
- The app is connected to Firebase project: taxiapp-b0cd7
- Use FirebaseService class for all database operations
- Handle Firebase errors gracefully with try-catch blocks
- Implement loading states for Firebase operations
- Use Firestore for real-time data synchronization
- Follow Firebase security best practices

## Code Structure
- Keep widgets small and focused on a single responsibility
- Use proper folder structure: lib/screens/, lib/widgets/, lib/models/, lib/services/
- Implement proper error handling and loading states
- Use meaningful variable and function names
- Separate Firebase logic into service classes

## UI/UX
- Prioritize clean, modern, and intuitive user interfaces
- Ensure proper accessibility support
- Use consistent theming and styling
- Implement smooth animations and transitions where appropriate
- Show loading indicators during Firebase operations
- Display helpful error messages to users

## Firebase Best Practices
- Always handle network connectivity issues
- Use transactions for critical data operations
- Implement offline capability where possible
- Use Firebase security rules appropriately
- Optimize Firestore queries for performance
- Handle Firebase authentication states properly

## Testing
- Write unit tests for business logic
- Include widget tests for UI components
- Consider integration tests for critical user flows
- Mock Firebase services in tests
- Test offline scenarios

## Performance
- Use StreamBuilder for real-time data
- Implement proper disposal of streams and listeners
- Cache data appropriately to reduce Firebase calls
- Use pagination for large data sets
