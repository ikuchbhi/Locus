# Locus

An app where users connect via locations. 
Makes coordinating meetups and sharing live locations simpler, easier and faster.

## Features:

1. Users can sign up by email+password or Google

2. Users can share Moments (analogous to a social media post), which contains:
    * a location (required)
    * a list of Users (optional) [tagged Users]  
    * content (a combination of text, photo or both)
3. Moments can also contain a collection of a content type (all same type)

4. Users can view their Loci (location history), which graphically is a map of all locations covered in a set timespan

5. Ideally a user suggestion algorithm should be present to help users interact with others who have similar Loci (location history), however a simple Search bar is present for now that allows searching for user's (similar to Discord and Instagram)

6. Users can create Domains (analogous to a Discord Server) and can also restrict the location region to something like a college campus, city or state.

## Technologies/Libraries to be used:
* Frontend: Flutter Material UI
* Backend: Supabase
* Environment management via flutter_dotenv
* State Management using BLoCs and the flutter_bloc library (with clean architecture) 

### Frontend: Flutter Material UI
---
The app's design will be based on Material UI having the following color scheme:
* Primary Color: #FB8B24
* Secondary Color: #0208FC
* Tertiary Color: #DADFF7
* Success Color: #48BB78
* Error Color: #BB342F

### Backend: Supabase
---
Supabase will be used for the following:
* Authentication: 
    * Username + Password
    * Google OAuth
* Storing Users:
    * Username (unique)
    * Email Address (unique)
    * Name
    * Biodata
* Storing Posts:
    * Location
    * Timestamp
    * Content
    * Tagged Users
    * Tags

### Environment management via flutter_dotenv
---
> Good software development practice :)

### State management using BLoCs and the flutter_bloc library (with clean architecture)
---
Out of all state management solutions, BLoC is generally preferred for medium to large scale projects. It also has a simple but powerful API used by many, making it the right choice compared to other state management solutions such as Provider, Riverpod, Redux, setState((){}), etc.

