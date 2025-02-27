First off, thanks for taking the time to contribute! ❤️

All types of contributions are encouraged and valued. If you are thinking about to include a new classification system, we are happy to include it. 

## How to Add a New Classification Polygons
To add a new soil texture classification system follow these steps:

1. **Check the current Data**:
   - Check the `data-raw/` folder to understand how the current classification polygons are created from scratch.

2. **Prepare the Data**:
   - Create a data frame with columns `sand`, `silt`,`clay`,`x`, `y`, and `label`.
   - The `x` and `y` columns should contain the coordinates for the polygon vertices in the ternary plot space, transformed as follows:
   `x = 0.5 * clay + silt` and `y = clay`
   - The `label` column should contain the name of the soil texture class (e.g., "Loam", "Sandy Clay").
   - The order of the data must ensure that the new classes are closed polygon. The order of vertices is critical for correct rendering. The correct order is bottom-left -> bottom-right -> top-right -> top-left based on `x` and `y` columns. 

3. **Save the Data**:
   - Save the data frame as an `.RData` file in the `data-raw/` folder.
   - Use a descriptive name for the file (e.g., `french_polygons.rda`).

4. **Update the Package**:
   - Add the new classification system to the `ggsoiltexture` function by modifying the `switch(class_data <-)` statement in the code.
   - Include an example in the function documentation.

5. **Submit a Pull Request**:
   - Fork the repository and create a new branch for your contribution.
   - Submit a pull request with a description of the new classification system and example usage.


## Before Submitting an Enhancement

- Make sure that you are using the latest version.
- Read the [documentation]() carefully and find out if the functionality is already covered, maybe by an individual configuration.
- Perform a [search](/issues) to see if the enhancement has already been suggested. If it has, add a comment to the existing issue instead of opening a new one.
- Find out whether your idea fits with the scope and aims of the project. It's up to you to make a strong case to convince the project's developers of the merits of this feature. Keep in mind that we want features that will be useful to the majority of our users and not just a small subset. If you're just targeting a minority of users, consider writing an add-on/plugin library.

## How Do I Submit a Good Enhancement Suggestion?

Enhancement suggestions are tracked as [GitHub issues](/issues).

- Use a **clear and descriptive title** for the issue to identify the suggestion.
- Provide a **step-by-step description of the suggested enhancement** in as many details as possible.
- **Describe the current behavior** and **explain which behavior you expected to see instead** and why. At this point you can also tell which alternatives do not work for you.
- You may want to **include screenshots and animated GIFs** which help you demonstrate the steps or point out the part which the suggestion is related to. You can use [this tool](https://www.cockos.com/licecap/) to record GIFs on macOS and Windows, and [this tool](https://github.com/colinkeenan/silentcast) or [this tool](https://github.com/GNOME/byzanz) on Linux. 
- **Explain why this enhancement would be useful** to most CONTRIBUTING.md users. You may also want to point out the other projects that solved it better and which could serve as inspiration.

## Attribution
This guide is based on the **contributing.md**. [Make your own](https://contributing.md/)!
