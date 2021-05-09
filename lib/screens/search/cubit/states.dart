abstract class SearchStates {}

class SearchStateInitial extends SearchStates {}

class SearchStateFailed extends SearchStates {}

class SearchStateLoading extends SearchStates {}

class SearchStateSuccess extends SearchStates {}

class SearchDetailsStateFailed extends SearchStates {}

class SearchDetailsStateSuccess extends SearchStates {}

class SearchGetDirectionStateSuccess extends SearchStates {}

class SearchGetDirectionStateFailed extends SearchStates {}
