# fa_flutter_logger

Official FA Flutter logger package.

## Getting Started

Add following code in `pubspec.yaml` file in `dependencies`:

```
  fa_flutter_logger:
    git:
      url: https://github.com/FieldAssist/fa_flutter_logger.git
      ref: master
```

## Usage

To use add following line as top level variable anywhere in your project

```
final AppLog logger = AppLogImpl();
```

### Debug

```
logger.d("debug value: $token");
```

### Exception

```
logger.e(e,stacktrace); // Use StackTrace.current in case no stacktrace available
```

### Info

```
logger.i("Api response: xyz");
```