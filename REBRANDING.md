# Rebranding Instructions

This project is a starter app. To rebrand it for your own use (e.g., change the package name, app name, etc.), follow these steps using the Dart/Flutter [`rename`](https://pub.dev/packages/rename) package.

## 1. Install the `rename` Package

You can use the [`rename`](https://pub.dev/packages/rename) Dart package to automate renaming across your Flutter project.

```bash
flutter pub global activate rename
```

## 2. Decide on Your New App Name

Choose your new app/package name. For example, if you want to rename from `starter_app` to `my_cool_app`, note both names.

## 3. Set the App Name

Run the following command in the root of your project to set the new app name for iOS and Android:

```bash
rename setAppName --targets ios,android --value "my_cool_app"
```

> **Note:**  
> - Make sure to back up your project or use version control before running bulk renames.
> - This will set the AppName for the iOS and Android platforms to "my_cool_app".

## 4. Update BundleId

Similarly, use `setBundleId` to set the BundleId for the specified platforms.

```bash
rename setBundleId --targets ios,android --value "com.example.bundleId"
```
> - This will set the BundleId for the iOS and Android platforms to "com.example.bundleId".

## 5. Test Your App

After renaming, run and test your app to ensure everything works as expected.

---

**Happy coding!**
