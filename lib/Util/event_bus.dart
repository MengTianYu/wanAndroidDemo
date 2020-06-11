
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';

EventBus eventBus = EventBus();

class LoginEvent{}
class LogoutEvent{}

class ChangeThemeEvent {

  MaterialColor color;

  ChangeThemeEvent(this.color);

}