class SearchWord {
    List<String> recommendWords;
    String suggestWord;

    SearchWord({this.recommendWords, this.suggestWord});

    factory SearchWord.fromJson(Map<String, dynamic> json) {
        return SearchWord(
            recommendWords: json['recommendWords'] != null ? new List<String>.from(json['recommendWords']) : null, 
            suggestWord: json['suggestWord'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['suggestWord'] = this.suggestWord;
        if (this.recommendWords != null) {
            data['recommendWords'] = this.recommendWords;
        }
        return data;
    }
}