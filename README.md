# SwiftCamp ®️

  <p>
This meaningful project is made possible thanks to the generous support of MasterFabric Technology Information Inc. and EduTech. Aiming to promote knowledge and innovation for the benefit of society,
We thank them for empowering us to create this non-profit project.
</p>

<p>
  SwiftCamp provides participants with more than just an understanding of the foundational concepts of the Swift programming language. It also offers hands-on experience in managing processes, planning, and collaboratively developing a mobile application. The program is structured in two phases:
</p>
<ul>
  <li><strong>Phase 1:</strong> Understanding user interface design and fundamental building blocks using SwiftUI.</li>
  <li><strong>Phase 2:</strong> Learning and applying hardware services, API integrations, and real-world application development.</li>
</ul>


[![Swift Camp](https://github.com/NurhayatYurtaslan/swift_camp/blob/dev/Assets/SwiftCamp.png?raw=true)](https://testflight.apple.com/join/vZBFC8hs)

<p>

  This application is developed using the VIPER architecture (View, Interactor, Presenter, Entity, Router) to ensure a clean, modular, and maintainable codebase.

How VIPER is Used:
View: Focuses on the UI and delegates logic to the Presenter.
Interactor: Manages business logic and data manipulation.
Presenter: Mediates between the View and Interactor, preparing data for display.
Entity: Contains data models and structures.
Router: Handles navigation and screen transitions.
Benefits:
Separation of Concerns: Each layer has a clear role, making the app easy to maintain.
Testability: Modular components are simple to test individually.
Scalability: Supports adding new features without disrupting existing functionality.
With VIPER, this app achieves a structured and scalable architecture that ensures long-term maintainability.
</p>

<h2>🚀 Achievements of SwiftCamp</h2>
<ul>
  <li>💻 <strong>Learning Swift Basics</strong>: Master the foundational elements of the Swift programming language and design user interfaces with SwiftUI.</li>
  <li>📋 <strong>Project Management Experience</strong>: Develop skills in task delegation, process planning, and coordination within a team environment.</li>
  <li>📱 <strong>Mobile App Development Process</strong>: Gain hands-on experience in creating a mobile application from initial design to deployment.</li>
  <li>🔧 <strong>Utilizing Hardware Services</strong>: Learn to access and integrate hardware features like cameras, sensors, and other device functionalities into applications.</li>
  <li>🔗 <strong>API and Service Integrations</strong>: Implement external services and APIs to create dynamic, user-focused applications.</li>
  <li>🤝 <strong>Teamwork Skills</strong>: Strengthen collaboration and communication skills by taking on various roles within a team.</li>
  <li>🌍 <strong>Real-World Application</strong>: Apply acquired knowledge in practical projects to gain proficiency in the iOS development ecosystem.</li>
</ul>


## 🛠 Attributes

Attributes are properties or modifiers that define the appearance, behavior, and interaction of SwiftUI components. Below is a categorized list of attributes you can apply to your views.

---

### 🎨 Appearance Attributes
- `foregroundColor`: Sets the color of text or shapes.
- `background`: Adds a background to the view.
- `shadow`: Applies a shadow effect.
- `cornerRadius`: Rounds the corners of a view.
- `opacity`: Adjusts the transparency of a view.
- `blendMode`: Applies a blend mode to the view.

---

### 📐 Layout Attributes
- `frame`: Sets the size of a view.
- `padding`: Adds spacing around a view.
- `offset`: Moves the view by a specified amount.
- `alignment`: Aligns the content within a container.
- `zIndex`: Sets the stacking order of views.

---

### 🎞️ Animation Attributes
- `animation`: Adds an animation to a view.
- `transition`: Defines how views appear/disappear.
- `matchedGeometryEffect`: Links views for smooth animations.
- `delay`: Adds a delay before an animation starts.

---

### 👆 Interaction Attributes
- `onTapGesture`: Detects a tap gesture.
- `onLongPressGesture`: Detects a long press gesture.
- `gesture`: Adds a custom gesture to a view.
- `allowsHitTesting`: Enables or disables user interaction.

---

### ⚙️ Functional Attributes
- `id`: Assigns a unique identifier to a view.
- `tag`: Associates a value with a view.
- `environment`: Passes shared data to child views.
- `accessibilityLabel`: Provides accessibility information.
- `focusable`: Marks a view as focusable.

---

### 🔧 Customization Attributes
- `customModifier`: Creates reusable custom modifiers.
- `preferenceKey`: Shares data between parent and child views.
- `layoutPriority`: Adjusts the layout priority of a view.

---

Attributes allow you to fine-tune the behavior and appearance of your SwiftUI views, creating a rich and dynamic user experience.


## ⚙️ Project Features

This document highlights all the SwiftUI components and features included in the project. Use this as a checklist to track your progress or ensure feature coverage. ✅

---

### 📦 View Containers
Containers are fundamental building blocks in SwiftUI. They allow you to structure and arrange your views hierarchically.

| **Container Types** | **Lazy Containers** | **Navigation & Grouping** |
|---------------------|---------------------|----------------------------|
| VStack              | LazyVStack         | NavigationView             |
| HStack              | LazyHStack         | NavigationStack            |
| ZStack              | LazyVGrid          | Group                      |
| ScrollView          | LazyHGrid          | GroupBox                   |
| List                |                    |                            |

---

### ✏️ Text and Images
SwiftUI provides powerful tools for working with text and images, enabling customization and interactivity.

| **Text Components** | **Interactive Fields** | **Image Components** |
|----------------------|------------------------|-----------------------|
| Text                | TextField             | Image                |
| SecureField         |                      | Label                |
| AttributedText      |                      |                       |

---

### 🔘 Buttons
Buttons and contextual menus enable user interaction, making your app responsive and dynamic.

| **Button Types** | **Contextual Buttons** |
|-------------------|------------------------|
| Button           | ContextMenu           |
| Link             | Menu                  |
| Toggle           |                       |

---

### 🎛️ Pickers and Controls
Pickers and controls offer flexible ways for users to input data and adjust settings.

| **Pickers**    | **Adjustable Controls** | **Indicators**       |
|----------------|------------------------|----------------------|
| Picker         | Slider                 | ProgressView         |
| DatePicker     | Stepper                | SegmentedControl     |
| ColorPicker    |                       |                      |

---

### 🔲 Shapes
Shapes are versatile drawing primitives that can be styled and combined for custom designs.

| **Basic Shapes**   | **Advanced Shapes** |
|--------------------|---------------------|
| Rectangle          | Path               |
| RoundedRectangle   | CustomShape        |
| Circle             |                   |
| Ellipse            |                   |
| Capsule            |                   |

---

### 🛠️ Modifiers
Modifiers customize the appearance, layout, and behavior of views in SwiftUI.

| **Appearance**     | **Positioning**     | **Effects**        |
|--------------------|---------------------|--------------------|
| Padding            | Frame              | Opacity           |
| Background         | Offset             | ScaleEffect       |
| ForegroundColor    |                   | RotationEffect    |
| Shadow             |                   |                   |

---

### 🎞️ Animations
Animations bring life to your UI, enhancing user experience with smooth transitions and dynamic effects.

| **Animation Types** | **Advanced Animation** |
|---------------------|------------------------|
| Animation           | MatchedGeometryEffect |
| withAnimation       | Transition            |
| Transaction         |                      |

---

### 👆 Gestures
Gestures are essential for detecting user interactions, enabling richer touch-based experiences.

| **Gestures**         | **Advanced Gestures** |
|----------------------|-----------------------|
| TapGesture           | MagnificationGesture |
| LongPressGesture     | RotationGesture      |
| DragGesture          |                      |

---

### ⚠️ Alerts and Sheets
Alerts and sheets provide ways to display modal content or prompt the user for confirmation.

| **Alerts**       | **Sheets and Dialogs**  |
|------------------|-------------------------|
| Alert            | Sheet                  |
| ActionSheet      | Popover                |
| ConfirmationDialog |                      |

---

### 🏗️ Grid
Grids are used for creating complex layouts with structured rows and columns.

| **Grid Types**  |
|-----------------|
| Grid            |
| GridRow         |

---

### 🧩 Other Components
Additional components that enhance layout, media integration, and state management.

| **Layout**         | **Media**            | **State Management**    |
|--------------------|----------------------|-------------------------|
| Spacer            | VideoPlayer         | State                  |
| Divider           | Map                 | Binding                |
| GeometryReader    | ProgressIndicator   | ObservedObject         |
| Canvas            |                     | EnvironmentObject      |
| TimelineView      |                     | FocusState             |

## 📦 Package Dependencies

| **Package**             | **Version** |
|--------------------------|-------------|
| OneSignalXCFramework    | 5.2.9       |
| RxSwift                 | 6.5.0       |



## 🪽 Volunter Partner

<table>
  <tbody>
    <tr>
      <td align="center" valign="top" width="14.28%">
        <a href="https://masterfabric.co/">
          <img src="https://media.licdn.com/dms/image/v2/D4D0BAQHMY1PizVx25g/company-logo_200_200/company-logo_200_200/0/1722714904714?e=1743638400&v=beta&t=VPrq6pnYVs5KZ7x1dcb0YxWTU6ACDU6M0sqD5hMsjKE" alt="MasterFabric" />
          <br /><sub><b>MasterFabric</b></sub>
        </a>
      </td>
      <td align="center" valign="center" width="14.28%">
        <a href="https://edutechtr.com/">
          <img src="https://edutechtr.com/wp-content/uploads/2024/12/Renkli-ana-logo.png" alt="EduTech" />
          <br /><sub><b>EduTech</b></sub>
        </a>
      </td>
    </tr>
  </tbody>
</table>


## ✨ Contributors
<table style="width: 100%; text-align: center; border-spacing: 10px;">
<tr><td style="width: 150px; height: 150px; text-align: center; vertical-align: top;"><a href="https://github.com/gurkanfikretgunak" style="text-decoration: none; color: inherit;"><div style="width: 120px; height: 120px; border-radius: 50%; overflow: hidden; margin: 0 auto;"><img src="https://avatars.githubusercontent.com/u/52853374?v=4" style="width: 100%; height: 100%; object-fit: cover;" alt="gurkanfikretgunak" /></div><br /><sub style="word-wrap: break-word; font-size: 14px; max-width: 120px; display: block;"><b>gurkanfikretgunak</b></sub></a></td>
<td style="width: 150px; height: 150px; text-align: center; vertical-align: top;"><a href="https://github.com/turhanGoksu" style="text-decoration: none; color: inherit;"><div style="width: 120px; height: 120px; border-radius: 50%; overflow: hidden; margin: 0 auto;"><img src="https://avatars.githubusercontent.com/u/92114756?v=4" style="width: 100%; height: 100%; object-fit: cover;" alt="turhanGoksu" /></div><br /><sub style="word-wrap: break-word; font-size: 14px; max-width: 120px; display: block;"><b>turhanGoksu</b></sub></a></td>
<td style="width: 150px; height: 150px; text-align: center; vertical-align: top;"><a href="https://github.com/mehmetalbyrak" style="text-decoration: none; color: inherit;"><div style="width: 120px; height: 120px; border-radius: 50%; overflow: hidden; margin: 0 auto;"><img src="https://avatars.githubusercontent.com/u/106533819?v=4" style="width: 100%; height: 100%; object-fit: cover;" alt="mehmetalbyrak" /></div><br /><sub style="word-wrap: break-word; font-size: 14px; max-width: 120px; display: block;"><b>mehmetalbyrak</b></sub></a></td>
<td style="width: 150px; height: 150px; text-align: center; vertical-align: top;"><a href="https://github.com/yuceel" style="text-decoration: none; color: inherit;"><div style="width: 120px; height: 120px; border-radius: 50%; overflow: hidden; margin: 0 auto;"><img src="https://avatars.githubusercontent.com/u/108794593?v=4" style="width: 100%; height: 100%; object-fit: cover;" alt="yuceel" /></div><br /><sub style="word-wrap: break-word; font-size: 14px; max-width: 120px; display: block;"><b>yuceel</b></sub></a></td>
<td style="width: 150px; height: 150px; text-align: center; vertical-align: top;"><a href="https://github.com/melihalkbk" style="text-decoration: none; color: inherit;"><div style="width: 120px; height: 120px; border-radius: 50%; overflow: hidden; margin: 0 auto;"><img src="https://avatars.githubusercontent.com/u/102410189?v=4" style="width: 100%; height: 100%; object-fit: cover;" alt="melihalkbk" /></div><br /><sub style="word-wrap: break-word; font-size: 14px; max-width: 120px; display: block;"><b>melihalkbk</b></sub></a></td></tr>
<tr><td style="width: 150px; height: 150px; text-align: center; vertical-align: top;"><a href="https://github.com/busragedikoglu" style="text-decoration: none; color: inherit;"><div style="width: 120px; height: 120px; border-radius: 50%; overflow: hidden; margin: 0 auto;"><img src="https://avatars.githubusercontent.com/u/84907307?v=4" style="width: 100%; height: 100%; object-fit: cover;" alt="busragedikoglu" /></div><br /><sub style="word-wrap: break-word; font-size: 14px; max-width: 120px; display: block;"><b>busragedikoglu</b></sub></a></td>
<td style="width: 150px; height: 150px; text-align: center; vertical-align: top;"><a href="https://github.com/alakkaya" style="text-decoration: none; color: inherit;"><div style="width: 120px; height: 120px; border-radius: 50%; overflow: hidden; margin: 0 auto;"><img src="https://avatars.githubusercontent.com/u/117384310?v=4" style="width: 100%; height: 100%; object-fit: cover;" alt="alakkaya" /></div><br /><sub style="word-wrap: break-word; font-size: 14px; max-width: 120px; display: block;"><b>alakkaya</b></sub></a></td>
<td style="width: 150px; height: 150px; text-align: center; vertical-align: top;"><a href="https://github.com/beyzanuravsar" style="text-decoration: none; color: inherit;"><div style="width: 120px; height: 120px; border-radius: 50%; overflow: hidden; margin: 0 auto;"><img src="https://avatars.githubusercontent.com/u/89158738?v=4" style="width: 100%; height: 100%; object-fit: cover;" alt="beyzanuravsar" /></div><br /><sub style="word-wrap: break-word; font-size: 14px; max-width: 120px; display: block;"><b>beyzanuravsar</b></sub></a></td>
<td style="width: 150px; height: 150px; text-align: center; vertical-align: top;"><a href="https://github.com/elifdodanli" style="text-decoration: none; color: inherit;"><div style="width: 120px; height: 120px; border-radius: 50%; overflow: hidden; margin: 0 auto;"><img src="https://avatars.githubusercontent.com/u/115662604?v=4" style="width: 100%; height: 100%; object-fit: cover;" alt="elifdodanli" /></div><br /><sub style="word-wrap: break-word; font-size: 14px; max-width: 120px; display: block;"><b>elifdodanli</b></sub></a></td>
<td style="width: 150px; height: 150px; text-align: center; vertical-align: top;"><a href="https://github.com/AylinManav" style="text-decoration: none; color: inherit;"><div style="width: 120px; height: 120px; border-radius: 50%; overflow: hidden; margin: 0 auto;"><img src="https://avatars.githubusercontent.com/u/116441339?v=4" style="width: 100%; height: 100%; object-fit: cover;" alt="AylinManav" /></div><br /><sub style="word-wrap: break-word; font-size: 14px; max-width: 120px; display: block;"><b>AylinManav</b></sub></a></td></tr>
<tr><td style="width: 150px; height: 150px; text-align: center; vertical-align: top;"><a href="https://github.com/NurhayatYurtaslan" style="text-decoration: none; color: inherit;"><div style="width: 120px; height: 120px; border-radius: 50%; overflow: hidden; margin: 0 auto;"><img src="https://avatars.githubusercontent.com/u/80510115?v=4" style="width: 100%; height: 100%; object-fit: cover;" alt="NurhayatYurtaslan" /></div><br /><sub style="word-wrap: break-word; font-size: 14px; max-width: 120px; display: block;"><b>NurhayatYurtaslan</b></sub></a></td>
<td style="width: 150px; height: 150px; text-align: center; vertical-align: top;"><a href="https://github.com/ayberkgorgun" style="text-decoration: none; color: inherit;"><div style="width: 120px; height: 120px; border-radius: 50%; overflow: hidden; margin: 0 auto;"><img src="https://avatars.githubusercontent.com/u/55927375?v=4" style="width: 100%; height: 100%; object-fit: cover;" alt="ayberkgorgun" /></div><br /><sub style="word-wrap: break-word; font-size: 14px; max-width: 120px; display: block;"><b>ayberkgorgun</b></sub></a></td>
<td style="width: 150px; height: 150px; text-align: center; vertical-align: top;"><a href="https://github.com/OnurArslan0" style="text-decoration: none; color: inherit;"><div style="width: 120px; height: 120px; border-radius: 50%; overflow: hidden; margin: 0 auto;"><img src="https://avatars.githubusercontent.com/u/120121161?v=4" style="width: 100%; height: 100%; object-fit: cover;" alt="OnurArslan0" /></div><br /><sub style="word-wrap: break-word; font-size: 14px; max-width: 120px; display: block;"><b>OnurArslan0</b></sub></a></td>
</table>

<table style="width: 100%; text-align: center; border-spacing: 10px;">
<tr><td style="width: 150px; height: 150px; text-align: center; vertical-align: top;"><a href="https://github.com/gurkanfikretgunak" style="text-decoration: none; color: inherit;"><div style="width: 120px; height: 120px; border-radius: 50%; overflow: hidden; margin: 0 auto;"><img src="https://avatars.githubusercontent.com/u/52853374?v=4" style="width: 100%; height: 100%; object-fit: cover;" alt="gurkanfikretgunak" /></div><br /><sub style="word-wrap: break-word; font-size: 14px; max-width: 120px; display: block;"><b>gurkanfikretgunak</b></sub></a></td>
<td style="width: 150px; height: 150px; text-align: center; vertical-align: top;"><a href="https://github.com/mehmetalbyrak" style="text-decoration: none; color: inherit;"><div style="width: 120px; height: 120px; border-radius: 50%; overflow: hidden; margin: 0 auto;"><img src="https://avatars.githubusercontent.com/u/106533819?v=4" style="width: 100%; height: 100%; object-fit: cover;" alt="mehmetalbyrak" /></div><br /><sub style="word-wrap: break-word; font-size: 14px; max-width: 120px; display: block;"><b>mehmetalbyrak</b></sub></a></td>
<td style="width: 150px; height: 150px; text-align: center; vertical-align: top;"><a href="https://github.com/turhanGoksu" style="text-decoration: none; color: inherit;"><div style="width: 120px; height: 120px; border-radius: 50%; overflow: hidden; margin: 0 auto;"><img src="https://avatars.githubusercontent.com/u/92114756?v=4" style="width: 100%; height: 100%; object-fit: cover;" alt="turhanGoksu" /></div><br /><sub style="word-wrap: break-word; font-size: 14px; max-width: 120px; display: block;"><b>turhanGoksu</b></sub></a></td>
<td style="width: 150px; height: 150px; text-align: center; vertical-align: top;"><a href="https://github.com/melihalkbk" style="text-decoration: none; color: inherit;"><div style="width: 120px; height: 120px; border-radius: 50%; overflow: hidden; margin: 0 auto;"><img src="https://avatars.githubusercontent.com/u/102410189?v=4" style="width: 100%; height: 100%; object-fit: cover;" alt="melihalkbk" /></div><br /><sub style="word-wrap: break-word; font-size: 14px; max-width: 120px; display: block;"><b>melihalkbk</b></sub></a></td>
<td style="width: 150px; height: 150px; text-align: center; vertical-align: top;"><a href="https://github.com/alakkaya" style="text-decoration: none; color: inherit;"><div style="width: 120px; height: 120px; border-radius: 50%; overflow: hidden; margin: 0 auto;"><img src="https://avatars.githubusercontent.com/u/117384310?v=4" style="width: 100%; height: 100%; object-fit: cover;" alt="alakkaya" /></div><br /><sub style="word-wrap: break-word; font-size: 14px; max-width: 120px; display: block;"><b>alakkaya</b></sub></a></td></tr>
<tr><td style="width: 150px; height: 150px; text-align: center; vertical-align: top;"><a href="https://github.com/busragedikoglu" style="text-decoration: none; color: inherit;"><div style="width: 120px; height: 120px; border-radius: 50%; overflow: hidden; margin: 0 auto;"><img src="https://avatars.githubusercontent.com/u/84907307?v=4" style="width: 100%; height: 100%; object-fit: cover;" alt="busragedikoglu" /></div><br /><sub style="word-wrap: break-word; font-size: 14px; max-width: 120px; display: block;"><b>busragedikoglu</b></sub></a></td>
<td style="width: 150px; height: 150px; text-align: center; vertical-align: top;"><a href="https://github.com/yuceel" style="text-decoration: none; color: inherit;"><div style="width: 120px; height: 120px; border-radius: 50%; overflow: hidden; margin: 0 auto;"><img src="https://avatars.githubusercontent.com/u/108794593?v=4" style="width: 100%; height: 100%; object-fit: cover;" alt="yuceel" /></div><br /><sub style="word-wrap: break-word; font-size: 14px; max-width: 120px; display: block;"><b>yuceel</b></sub></a></td>
<td style="width: 150px; height: 150px; text-align: center; vertical-align: top;"><a href="https://github.com/beyzanuravsar" style="text-decoration: none; color: inherit;"><div style="width: 120px; height: 120px; border-radius: 50%; overflow: hidden; margin: 0 auto;"><img src="https://avatars.githubusercontent.com/u/89158738?v=4" style="width: 100%; height: 100%; object-fit: cover;" alt="beyzanuravsar" /></div><br /><sub style="word-wrap: break-word; font-size: 14px; max-width: 120px; display: block;"><b>beyzanuravsar</b></sub></a></td>
<td style="width: 150px; height: 150px; text-align: center; vertical-align: top;"><a href="https://github.com/elifdodanli" style="text-decoration: none; color: inherit;"><div style="width: 120px; height: 120px; border-radius: 50%; overflow: hidden; margin: 0 auto;"><img src="https://avatars.githubusercontent.com/u/115662604?v=4" style="width: 100%; height: 100%; object-fit: cover;" alt="elifdodanli" /></div><br /><sub style="word-wrap: break-word; font-size: 14px; max-width: 120px; display: block;"><b>elifdodanli</b></sub></a></td>
<td style="width: 150px; height: 150px; text-align: center; vertical-align: top;"><a href="https://github.com/ayberkgorgun" style="text-decoration: none; color: inherit;"><div style="width: 120px; height: 120px; border-radius: 50%; overflow: hidden; margin: 0 auto;"><img src="https://avatars.githubusercontent.com/u/55927375?v=4" style="width: 100%; height: 100%; object-fit: cover;" alt="ayberkgorgun" /></div><br /><sub style="word-wrap: break-word; font-size: 14px; max-width: 120px; display: block;"><b>ayberkgorgun</b></sub></a></td></tr>
<tr><td style="width: 150px; height: 150px; text-align: center; vertical-align: top;"><a href="https://github.com/AylinManav" style="text-decoration: none; color: inherit;"><div style="width: 120px; height: 120px; border-radius: 50%; overflow: hidden; margin: 0 auto;"><img src="https://avatars.githubusercontent.com/u/116441339?v=4" style="width: 100%; height: 100%; object-fit: cover;" alt="AylinManav" /></div><br /><sub style="word-wrap: break-word; font-size: 14px; max-width: 120px; display: block;"><b>AylinManav</b></sub></a></td>
<td style="width: 150px; height: 150px; text-align: center; vertical-align: top;"><a href="https://github.com/OnurArslan0" style="text-decoration: none; color: inherit;"><div style="width: 120px; height: 120px; border-radius: 50%; overflow: hidden; margin: 0 auto;"><img src="https://avatars.githubusercontent.com/u/120121161?v=4" style="width: 100%; height: 100%; object-fit: cover;" alt="OnurArslan0" /></div><br /><sub style="word-wrap: break-word; font-size: 14px; max-width: 120px; display: block;"><b>OnurArslan0</b></sub></a></td>
</table>


## 🧑🏻‍💻 Trainer 
  <table>
  <tbody>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/gurkanfikretgunak"><img src="https://avatars.githubusercontent.com/u/52853374?v=4" width="100px;" alt="Gürkan Fikret Günak"/><br /><sub><b>Gürkan Fikret Günak</b></sub></a><br /></td>
  </tbody>
  </table>
  
  ## 🧑🏻‍💻 Asistant 
  <table>
  <tbody>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/NurhayatYurtaslan"><img src="https://avatars.githubusercontent.com/u/80510115?v=4" width="100px;" alt="Nurhayat Yurtaslan"/><br /><sub><b>Nurhayat Yurtaslan</b></sub></a><br /></td>
  </tbody>
  </table>
  
## 📝 License
Copyright © 2024 - [View License](https://github.com/masterfabric-mobile/swift_camp/blob/dev/LICENSE)
