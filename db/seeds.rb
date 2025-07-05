
# 構文
# モデル名.create(カラム名: '入れる値', カラム名: '入れる値')

#questionsマスタテーブル初期データ
Question.create(fatigue_category:'身体の疲労',question_content: '体がだるい・重いと感じますか？')
Question.create(fatigue_category:'身体の疲労',question_content: '食欲はありますか？')
Question.create(fatigue_category:'身体の疲労',question_content: '最近ぐっすり眠れていますか？')
Question.create(fatigue_category:'心の疲労',question_content: '感情の起伏が激しいと感じますか？')
Question.create(fatigue_category:'心の疲労',question_content: '孤独や寂しさを感じることが多いですか？')
Question.create(fatigue_category:'心の疲労',question_content: '気分が晴れない・イライラすることが多いですか？')
Question.create(fatigue_category:'脳の疲労',question_content: '集中力が続かないと感じますか？')
Question.create(fatigue_category:'脳の疲労',question_content: 'やるべきことに手がつけられませんか？')
Question.create(fatigue_category:'脳の疲労',question_content: '頭が働かない・ぼーっとする感じがありますか？')

#choicesマスタテーブル初期データ
Choice.create(question_id: 1,choice_content: 'まったく感じない',score: 0)
Choice.create(question_id: 1,choice_content: 'あまり感じない',score: 1)
Choice.create(question_id: 1,choice_content: 'どちらとも言えない',score: 2)
Choice.create(question_id: 1,choice_content: 'やや感じる',score: 3)
Choice.create(question_id: 1,choice_content: 'とても感じる',score: 4)
Choice.create(question_id: 2,choice_content: '食欲は適切で、ちょうどよく食べられている',score: 0)
Choice.create(question_id: 2,choice_content: 'やや食べすぎていると感じる',score: 1)
Choice.create(question_id: 2,choice_content: 'あまり食欲がなく、食事量が少ない',score: 2)
Choice.create(question_id: 2,choice_content: '明らかに食べすぎていると感じる',score: 3)
Choice.create(question_id: 2,choice_content: 'ほとんど食べられず、食欲がまったくない',score: 4)
Choice.create(question_id: 3,choice_content: 'とてもよく眠れており、すっきり目覚めた',score: 0)
Choice.create(question_id: 3,choice_content: '大体眠れており、日中も問題なく過ごせる',score: 1)
Choice.create(question_id: 3,choice_content: '時々眠れない日があり、やや眠気が残る',score: 2)
Choice.create(question_id: 3,choice_content: 'よく眠れず、寝不足を感じている',score: 3)
Choice.create(question_id: 3,choice_content: '寝すぎてしまい、起きてもだるさが残る・まったく眠れない',score: 4)


#diagnosis_resultsマスタテーブル初期データ

