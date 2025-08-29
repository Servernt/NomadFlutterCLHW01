import 'dart:io';

typedef Word = Map<String, String>;
typedef WordList = List<Word>;

class Dictionary {
  late final String term;
  late final String definition;
  Word _words = {};

  void add({required term, required definition}) {
    _words[term] = definition;
    print('Added "$term" to the dictionary.');
  }

  String? get({required String term}) {
    return _words[term];
  }

  void delete({required String term}) {
    if (_words.containsKey(term)) {
      _words.remove(term);
      print('Deleted "$term" from the dictionary.');
    } else {
      print('The term "$term" was not found in the dictionary.');
    }
  }

  void update({required String term, required String newDefinition}) {
    if (_words.containsKey(term)) {
      _words[term] = newDefinition;
      print('Updated "$term" in the dictionary.');
    } else {
      print('The term "$term" was not found in the dictionary.');
    }
  }

  void showAll() {
    if (_words.isNotEmpty) {
      print("All terms in the dictionary:");
      _words.forEach((term, definition) {
        print('Term: $term, Definition: $definition');
      });
    } else {
      print('The dictionary is empty.');
    }
  }

  int count() {
    return _words.length;
  }

  void upsert({required String term, required String definition}) {
    if (_words.containsKey(term)) {
      update(term: term, newDefinition: definition);
    } else {
      add(term: term, definition: definition);
    }
  }

  void exists(term) {
    if (_words.containsKey(term)) {
      print('The term "$term" exists in the dictionary.');
    } else {
      print('The term "$term" does not exist in the dictionary.');
    }
  }

  void bulkAdd(WordList words) {
    words.forEach((word) {
      final term = word["term"];
      final definition = word["definition"];
      if (term != null && definition != null) {
        add(term: term, definition: definition);
      } else {
        print('Skipped adding a word due to missing term or definition.');
      }
    });
  }

  void bulkDelete(List<String> terms) {
    terms.forEach((term) {
      delete(term: term);
    });
  }
}

void main() {
  var MyDictionary = Dictionary();

  print('\n 1.  add: 단어를 추가함.');
  MyDictionary.add(term: "Dart", definition: "와 대박..");
  MyDictionary.add(term: "야근", definition: "힘들다.");
  MyDictionary.add(term: "업무", definition: "힘들다");
  print('\n 2.  get: 단어의 정의를 리턴함.');
  print('"term" : "Dart", "definition" : "${MyDictionary.get(term: "Dart")}"');
  print('\n 3.  delete: 단어를 삭제함.');
  MyDictionary.delete(term: "야근");
  print('\n 4.  update: 단어를 업데이트 함.');
  MyDictionary.update(term: "업무", newDefinition: "즐겁다");
  print('\n 5.  showAll: 사전 단어를 모두 보여줌.');
  MyDictionary.showAll();
  print('\n 6.  count: 사전 단어들의 총 갯수를 리턴함.');
  print('Total terms in the dictionary: ${MyDictionary.count()}');
  print(
    '\n 7.  upsert 단어를 업데이트 함. 존재하지 않을시. 이를 추가함. (update + insert = upsert)',
  );
  MyDictionary.upsert(term: "Dart", definition: "진짜 대박..");
  MyDictionary.upsert(term: "AI", definition: "혁명이다.");
  print('\n 8.  exists: 해당 단어가 사전에 존재하는지 여부를 알려줌.');
  MyDictionary.exists("Dart");
  MyDictionary.exists("야근");
  print(
    '\n 9.  bulkAdd: 다음과 같은 방식으로. 여러개의 단어를 한번에 추가할 수 있게 해줌. [{"term":"김치", "definition":"대박이네~"}, {"term":"아파트", "definition":"비싸네~"}]',
  );
  MyDictionary.bulkAdd([
    {"term": "김치", "definition": "대박이네~"},
    {"term": "아파트", "definition": "비싸네~"},
  ]);
  MyDictionary.showAll();

  print(
    '\n 10. bulkDelete: 다음과 같은 방식으로. 여러개의 단어를 한번에 삭제할 수 있게 해줌. ["김치", "아파트"]',
  );
  MyDictionary.bulkDelete(["김치", "아파트"]);
  MyDictionary.showAll();
}
