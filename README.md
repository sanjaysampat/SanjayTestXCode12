#  SanjayTestXcode12
Common project creation to learn.

## Version
1.0

### Topics to learn

1. SwiftUI project.
    * Test code for various controls
    * Images display in LazyHGrid with bindable data of images. 
        * Created ItemImage struct which is Identifiable, Hashable
    
2. GIT integration
    * Added Project to GIT from XCode 12 Beta
    * Commit, Push, Fetch from XCode

3. PHPhotoPicker
* Single image selection with PHPickerResult using .itemProvider. There is issue of access permission ( code is commented. )
    * Multiple images selection with PHAsset withLocalIdentifiers. Access permission is asked to user when we try to get full size original selected image. If permission is not granted then we get thumbnail size low quality image.
    * When we tried to call PHPhotoLibrary.requestAuthorization, system decides to show prompt to user, if user has not permitted earlier, system will not show the prompt. So we have shown message label to user to grand permission via iOS settings. 

4. Markdown format for README.md

5. Use of SF Symbols for **systemImage** icons.
    * [System Icons](https://developer.apple.com/design/human-interface-guidelines/ios/icons-and-images/system-icons/) (iOS12  and Earlier)
    * There are over 1,500 symbols text that can be used in apps running in iOS 13 and later. To browse the full set of symbols, download [the SF Symbols mac app](https://developer.apple.com/design/downloads/SF-Symbols.dmg). 



