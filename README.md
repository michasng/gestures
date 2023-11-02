# Gestures

A video dictionary for one dialect of German sign language. 👋

This progessive web app allows users to browse a large library of signs by category or find specific ones by their corresponding German words. A list of favorites enables quick access to important words.

This project was realized in cooperation with [Ursberger Gebärden](https://www.ursberger-gebaerden.de/).

It is now live on https://ursberger-gebaerden.web.app.
A production account is required for video access.

## Cached app content

Changes to the storage bucket or to assets/synonyms.json are not immediately reflected in the app.
The app uses a cached version of the app content in order to reduce loading times.

A privileged user can export an updated version of this file from the main menu.

CORS settings of the storage bucket have been adjusted by following [this SO answer](https://stackoverflow.com/a/58613527/5120356), so we can http GET this file from any origin.
