# Nha Gia Re

- **Giới thiệu đề tài:**
  - Nhà giá rẻ là một ứng dụng giúp cho những người mua bán hoặc thuê bất động sản tìm kiếm và chọn được bất động sản theo nhu cầu của mình. Ứng dụng hỗ trợ người dùng tìm kiếm bất động sản phù hợp nhất với nhu cầu của mình, cũng như kết nối họ với những cá nhân, nhà môi giới có nhu cầu đăng tin bất động sản một cách dễ dàng và tiện lợi.
  - Nhà giá rẻ có các chức năng cơ bản như tìm kiếm bất động sản, chat với người môi giới, đăng tin bất động sản, xem blog về bất động sản,...
- **Danh sách chức năng:**
  - Quản lý tài khoản người dùng
  - Quản lí bài đăng
  - Đăng kí gói đăng bài pro
  - Đăng tin bất động sản
  - Tìm kiếm bất động sản ở gần bạn
  - Tìm kiếm bất động sản theo vị trí
  - Chat với người đăng tin

# Project stucture

```
// Directory structure for assets and app
- assets
  - lotties: contains lotifile and animate files
  - icons : contains icon images for usage
  - images: contains app images
  - fonts : contains app fonts (you can using GoogleFont package)

- cofig:
    - theme: contains app theme (theme, colors, text styles, etc.)
    - languages: contains app translation (en, vi, etc.)
    - routes
        - app_pages.dart: routes to corresponding pages
        - app_routes.dart: contains names of routes
- core:
    - constants: contains common constants for app (api, etc.)
    - errors: contains error handling (exceptions, failure, etc.)
    - extensions: contains extensions for values in app ( String, DateTime, etc.)
    - network: contains network information (check internet connection, etc.)
    - resources: contains common resources (assets, abstart class of state, etc.)
    - usecases: abstract class for usecases
    - utils: contains common utility functions for app
- features:
    - data:
        - db: contains database (API, database, firebase, etc.)
        - datasources: contains data sources (local, remote, etc.)
        - models: contains models for data
        - repositories: contains repositories for data
    - domain: contains domain layer (entities, usecases, etc.)
        - enums: contains self-defined enums
        - entities: contains entities for domain
        - repositories: contains repositories for domain
        - usecases: contains usecases for domain
    - presentation: contains presentation layer (pages, widgets, blocs, etc.)
        - global_widgets: contains frequently used widgets in the app
        - <module_name>: named after the functional name
            - screens: contains pages for the feature
            - widgets: contains local widgets only used in this feature
            - <module_name>\_controller.dart: Initializes controller for the feature
            - <module_name>\_binding.dart: Defines functions and variables for controller
- injection_container.dart: contains dependency injection
- main.dart
```

# References
https://medium.com/@samra.sajjad0001/flutter-clean-architecture-5de5e9b8d093\
https://ashiqulislamshaon.medium.com/flutter-clean-architecture-using-getx-state-management-a5cd0464f4a1\
https://github.com/shirvanie/flutter_messenger_clean_architecture/tree/master\
https://github.com/RifkiCS29/headline_news
