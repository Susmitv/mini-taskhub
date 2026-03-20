#  Mini TaskHub – Flutter Internship Assignment

A simple and clean task management app built using Flutter and Supabase.


## 🚀 Features

-  User Authentication (Login / Signup using Supabase)
-  Add, Delete Tasks
-  Mark tasks as Completed
-  Light / Dark Theme Toggle
-  Clean UI based on modern design
-  Smooth animations
-  State management using Provider


##  Tech Stack

- Flutter
- Supabase
- Provider (State Management)

---

## Folder Structure
lib/
    main.dart
    app/
        theme.dart
    auth/
        auth_service.dart
        login_screen.dart
        signup_screen.dart
    dashboard/
        dashboard_screen.dart
        task_model.dart
        task_tile.dart
    providers/
        auth_provider.dart
        task_provider.dart
        theme_provider.dart
    services/
        supabase_service.dart
    settings/
        settings_screen.dart
    test/
        task_model_test.dart
    utils/
        validators.dart
    
##  Setup Instructions

1. Clone the repository:
2. Navigate to project:
    cd mini_taskhub
3. Install dependencies:
    flutter pub get
4. Add your Supabase credentials in `main.dart`:
    - Project URL
    - Anon Key
5. Run the app:
    flutter run


##  Supabase Setup

1. Create a project in Supabase  
2. Create a table: `tasks`

### Columns:
- id (uuid)
- user_id (uuid)
- title (text)
- is_completed (bool)
- created_at (timestamp)


###  Enable RLS Policies:

- SELECT → `auth.uid() = user_id`
- INSERT → `auth.uid() = user_id`
- DELETE → `auth.uid() = user_id`
- UPDATE → `auth.uid() = user_id`


##  Hot Reload vs Hot Restart

- **Hot Reload (`r`)** → Updates UI instantly without restarting
- **Hot Restart (`R`)** → Restarts the app completely


##  Demo Video

 (https://drive.google.com/file/d/1tMNMWoBCkCKPP2Oj1T-QPkw7pJwlf6iU/view?usp=sharing)


##  Bonus Features

- Task completion toggle 
- Dark mode 
- Settings screen 


##  Author

- Susmit Vaidya