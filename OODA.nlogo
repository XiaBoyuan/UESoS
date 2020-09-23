extensions [ vid ]

;;Declare the equip node type
breed [reconnaissances reconnaissance]
breed [commands command]
breed [hittings hitting]
breed [recbases recbase]
breed [commandbases commandbase]
breed [hitbases hitbase]

;;Declare the edge type
directed-link-breed [recLinks recLink]
directed-link-breed [communiLinks communiLink]
directed-link-breed [commandLinks commandLink]
directed-link-breed [hitLinks hitLink]

;Declare the properties of the Agents
turtles-own [side mobility availability  maxSpeed recRange recNumLimit communiRange communiNumLimit commCap commNumLimit
  hitRange hitNumLimit objList taskObj attackCap healthPoint curRes resRecPer recCost commCost hitCost  velocity flockingmates colisionmates ]
patches-own [redNum blueNum ]

; Declare global variables
globals [RwinB numOfRedRec numOfRedCom numOfRedHit numOfRedNode numOfBlueRec numOfBlueCom numOfBlueHit numOfBlueNode k test numOfRedDie numOfBlueDie zhenChaNengLi iterate  numOfRedNodeList numOfBlueNodeList numOfRedDielist numOfBlueDielist redZhanjuList blueZhanjuList  weiZhiList  ]

;;Initialization Settings
to setup
  clear-all
  setup-map
  setup-shape
  setup-bases
  do-plot-num ;figure 1 setting
  do-plot-numOfDie ;figure 2 setting
  set k 0
  set test 1

  set numOfRedNodeList []
  set numOfBlueNodeList []
  set numOfRedDielist []
  set numOfBlueDielist []
  set redZhanjuList []
  set blueZhanjuList []
  set RwinB []
  reset-ticks
  vid:reset-recorder
  set iterate 1
  ask patches [ set redNum 0  set blueNum 0 ]
end

 ;; interface setting
to setup-map
    ask patches [ set pcolor sky + 4.9 ]
end

 ;;shape setting
to setup-shape
  set-default-shape reconnaissances "intelligent"
  set-default-shape commands "command"
  set-default-shape hittings "strike"
  set-default-shape recbases "intbase"
  set-default-shape commandbases "commandbase"
  set-default-shape hitbases "strikebase"

  set-default-shape recLinks "link2" ask recLinks [ set color red   ]
  set-default-shape communiLinks "link2" ask communiLinks [ set color 43  ]
  set-default-shape commandLinks "link2" ask commandLinks [ set color blue ]
  set-default-shape hitLinks "link2" ask hitLinks [ set color black ]
end

;; base-agent setting
to setup-bases       ;x  y  side mobi avai  mSp recRange     recNumLimit    commniRange    communiNumLimit    commCapbility commNumLimit         hitRange    hitNumLimit    objL task  attackCap healthpoint curRes resRecPer recCost decCost hitCost
  createRecbases      40 20   1   0    1     1.5  recRangeRed  recNumLimitRed communiRangeRed  communiNumLimitRed      0         0                  0              0          []  []      10        100       1000  10   100  100   100
  createCommandbases  20 20   1   0    1     1.5   0                  0       communiRangeRed  communiNumLimitRed      1  communiNumLimitRed        0              0          []  []      10        100       1000  10   100  100   100
  createHitbases      20 40   1   0    1     1.5   0                  0       communiRangeRed  communiNumLimitRed      0         0              hitRangeRed   hitNumLimitRed  []  []      10        100       1000  10   100  100   100

  createRecbases      160 180 2   0    1     1.5  recRangeBlue recNumLimitBlue communiRangeBlue communiNumLimitBlue    0         0                  0              0          []  []      10        100       1000  10   100  100   100
  createCommandbases  180 180 2   0    1     1.5   0                  0       communiRangeBlue communiNumLimitBlue     1  communiNumLimitRed        0              0          []  []      10        100       1000  10   100  100   100
  createHitbases      180 160 2   0    1     1.5   0                  0       communiRangeBlue communiNumLimitBlue     0         0             hitRangeBlue   hitNumLimitBlue []  []      10        100       1000  10   100  100   100
  set numOfRedNode 0
  set numOfBlueNode 0
  set numOfRedDie 0
  set numOfBlueDie 0
end

;;create observer base Agent
to createRecbases [x y side1 mobility1 availability1 maxSpeed1 intRange1 intNumLimit1 communiRange1 communiNumLimit1 commCap1 commNumLimit1 attRange1 attNumLimit1 objList1 taskObj1 attackCap1 healthPoint1 curRes1 resRecPer1 intCost1 commCost1 strCost1 ]
  create-recbases 1
  [set heading 90
    setxy x y
    set side side1
    ifelse side = 1
    [set color 15]
    [set color 105]
    set size 10
    set mobility mobility1
    set availability availability1
    set maxSpeed maxSpeed1
    set recRange intRange1
    set recNumLimit intNumLimit1
    set communiRange communiRange1
    set communiNumLimit communiNumLimit1
    set commCap commCap1
    set commNumLimit commNumLimit1
    set hitRange attRange1
    set hitNumLimit attNumLimit1
    set objList objList1
    set taskObj taskObj1
    set attackCap attackCap1
    set healthPoint healthPoint1
    set curRes curRes1
    set resRecPer resRecPer1
    set recCost intCost1
    set commCost commCost1
    set hitCost strCost1
    set velocity [0 0]
    set flockingmates []
    set colisionmates []
  ]
end

;;create decider base Agent
to  createCommandbases [x y side1 mobility1 availability1 maxSpeed1 intRange1 intNumLimit1 communiRange1 communiNumLimit1 commCap1 commNumLimit1
  attRange1 attNumLimit1 objList1 taskObj1 attackCap1 healthPoint1 curRes1 resRecPer1 intCost1 commCost1 strCost1 ]
  create-commandbases 1
  [set heading 90
    setxy x y
    set side side1
    ifelse side = 1
    [set color 16]
    [set color 106]
    set size 10
    set mobility mobility1
    set availability availability1
    set maxSpeed maxSpeed1
    set recRange intRange1
    set recNumLimit intNumLimit1
    set communiRange communiRange1
    set communiNumLimit communiNumLimit1
    set commCap commCap1
    set commNumLimit commNumLimit1
    set hitRange attRange1
    set hitNumLimit attNumLimit1
    set objList objList1
    set taskObj taskObj1
    set attackCap attackCap1
    set healthPoint healthPoint1
    set curRes curRes1
    set resRecPer resRecPer1
    set recCost intCost1
    set commCost commCost1
    set hitCost strCost1
    set velocity [0 0]
      set flockingmates []
    set colisionmates []
  ]
end

;;create executor base Agent
to  createHitbases [x y side1 mobility1 availability1 maxSpeed1 intRange1 intNumLimit1 communiRange1 communiNumLimit1 commCap1 commNumLimit1
  attRange1 attNumLimit1 objList1 taskObj1 attackCap1 healthPoint1 curRes1 resRecPer1 intCost1 commCost1 strCost1 ]
  create-hitbases 1
  [set heading 90
    setxy x y
    set side side1
    ifelse side = 1
    [set color 17]
    [set color 107]
    set size 10
    set mobility mobility1
    set availability availability1
    set maxSpeed maxSpeed1
    set recRange intRange1
    set recNumLimit intNumLimit1
    set communiRange communiRange1
    set communiNumLimit communiNumLimit1
    set commCap commCap1
    set commNumLimit commNumLimit1
    set hitRange attRange1
    set hitNumLimit attNumLimit1
    set objList objList1
    set taskObj taskObj1
    set attackCap attackCap1
    set healthPoint healthPoint1
    set curRes curRes1
    set resRecPer resRecPer1
    set recCost intCost1
    set commCost commCost1
    set hitCost strCost1
    set velocity [0 0]
      set flockingmates []
    set colisionmates []
  ]
end

;; Drawing (amount of equipment of both sides)
to do-plot-num
  set-current-plot "Current amounts of agents"
  set-current-plot-pen "Red"
  plot numOfRedNode
  set-current-plot-pen "Blue"
  plot numOfBlueNode
end
;; Draw the number of destroyed agents of both sides
to do-plot-numOfDie
  set-current-plot "Current amounts of destroyed agents"
  set-current-plot-pen "Red"
  plot numOfRedDie
  set-current-plot-pen "Blue"
  plot numOfBlueDie
end

;; start running
to go
  if (ticks mod 5) = 0  [ addNode ]
  move
  reConnecte
  check
  do-plot-num
  do-plot-numOfDie

  if not any? turtles with [side = 1] or not any? turtles with [side = 2] or ticks > 2000
  [
    set numOfRedNodeList sentence numOfRedNodeList numOfRedNode
    set numOfBlueNodeList sentence numOfBlueNodeList numOfBlueNode
    set numOfRedDielist sentence numOfRedDielist numOfRedDie
    set numOfBlueDielist sentence numOfBlueDielist numOfBlueDie
    set RwinB sentence RwinB (numOfRedNode - numOfBlueNode)
    stop
;; making sensitive analysis of recnnaissance capability of red camp
;    ifelse recRangeRed > 150
;    [ stop ]
;    [
;      reset-ticks
;      ifelse test mod 10 = 0
;      [ set test test + 1
;        set recRangeRed recRangeRed + 1
;        setup-bases
;        go
;      ]
;      [ set test test + 1
;        setup-bases
;        go
;      ]
;    ]
  ]
  tick
  if vid:recorder-status = "recording" [ vid:record-interface ]
end

;; check
to check
  set numOfRedRec  count turtles with [breed = reconnaissances and side = 1]
  set numOfRedCom  count turtles with [breed = commands and side =  1]
  set numOfRedHit  count turtles with [breed = hittings and side = 1]
  set numOfRedNode  numOfRedRec + numOfRedCom + numOfRedHit

  set numOfBlueRec   count turtles with [breed = reconnaissances and side = 2]
  set numOfBlueCom  count turtles with [breed = commands and side = 2]
  set numOfBlueHit  count turtles with [breed = hittings and side = 2]
  set numOfBlueNode numOfBlueRec + numOfBlueCom + numOfBlueHit
end

;new agent introduction
to addNode
  if (k mod 3) = 0
  [if any? recbases
    [ask recbases
      [ifelse curRes >= recCost
        [ hatch-reconnaissances 1 [set mobility 1 ]
          set curRes (curRes - recCost)
          set curRes (curRes + resRecPer)
        ]
        [set curRes (curRes + resRecPer)]
      ]
    ]
  ]

  if (k mod 3) = 1
  [if any? commandbases
    [ask commandbases
      [ifelse curRes >= commCost
        [ hatch-commands 1 [set mobility 1 ]
          set curRes (curRes - commCost)
          set curRes (curRes + resRecPer)
        ]
        [set curRes (curRes + resRecPer)]
      ]
    ]
  ]

  if (k mod 3) = 1
  [if any? hitbases
    [ask hitbases
      [ifelse curRes >= hitCost
        [ hatch-hittings 1 [set mobility 1]
          set curRes (curRes - hitCost)
          set curRes (curRes + resRecPer)
        ]
        [set curRes (curRes + resRecPer)]
      ]
    ]
  ]
  set k k + 1
end

;; edge reconnection
to reConnecte
  reconnaissanceActivity
  communicateActivity
  commandActivity
  hitActivity
end

;; reconnaissance activity
to reconnaissanceActivity
  ask recLinks [die]
  ask reconnaissances [set objList []]
  ask reconnaissances with [availability = 1] ;创建侦查连边
  [ if any? other turtles with [ side != [side] of myself and distance myself <= [recRange] of myself]
    [ ifelse count other turtles with [ side != [side] of myself and distance myself <= [recRange] of myself] <= recNumLimit
      [ ask other turtles with [side != [side] of myself and distance myself <= [recRange] of myself]
        [create-recLink-to myself]

        set objList [list who healthPoint] of other turtles with [side != [side] of myself and distance myself <= [recRange] of myself]
      ]
      [ ask min-n-of recNumLimit other turtles with [side != [side] of myself and distance myself <= [recRange] of myself] [ distance myself ]
        [create-recLink-to myself]
        set objList [list who healthPoint] of (min-n-of recNumLimit other turtles with [side != [side] of myself and distance myself <= [recRange] of myself] [ distance myself ])

      ]
    ]
  ]
  if any? recLinks [ ask recLinks [ set color red ] ]
end

;; communication activity
to communicateActivity
  ask communiLinks [die]
  ask commands [set objList []]
  ask reconnaissances with [availability = 1 and not empty? objList]
  [ if any?  commands with [ side = [side] of myself and distance myself <= [communiRange] of myself]
    [ ifelse count  commands with [ side = [side] of myself and distance myself <= [communiRange] of myself] <= communiNumLimit
      [ ask commands with [ side = [side] of myself and distance myself <= [communiRange] of myself]
        [ create-communiLink-from myself
          set objList sentence [objList] of myself objList
          set objList remove-duplicates objList
        ]
      ]
      [ ask min-n-of communiNumLimit  commands with [ side = [side] of myself and distance myself <= [communiRange] of myself] [distance myself]
        [ create-communiLink-from myself
          set objList sentence [objList] of myself objList
          set objList remove-duplicates objList
        ]
      ]
    ]
  ]
  if any? communiLinks [ask communiLinks [ set color 43]]
end

;command activity
to commandActivity
  ask commandLinks [die]
  ask commands with [availability = 1 and not empty? objList]
  [ if any? other hittings with [ side = [side] of myself and distance myself <= [communiRange] of myself]
    [ ifelse count hittings with [ side = [side] of myself and distance myself <= [communiRange] of myself ] <= communiNumLimit
      [ ask hittings with [ side = [side] of myself and distance myself <= [communiRange] of myself ]
        [ create-commandLink-from myself
          set objList  [objList] of myself
          set objList sort-by [ [list1 list2 ]-> last list1 < last list2 ] objList
          set taskObj []
          set taskObj first objList
        ]
      ]
      [ ask min-n-of communiNumLimit hittings with [ side = [side] of myself and distance myself <= [communiRange] of myself ] [distance myself]
        [ create-commandLink-from myself
          set objList  [objList] of myself
          set objList sort-by [ [list1 list2 ]-> last list1 < last list2 ] objList
          set taskObj []
          set taskObj first objList
        ]
      ]
    ]
  ]
  if any? commandLinks [ask commandLinks [ set color blue ]]
end

;hitting activity
to hitActivity
  ask hitLinks [die]
  ask hittings with [ availability = 1 and not empty? taskObj ]
  [ if any? turtles with [ who = first [taskObj] of myself]
    [ if distance turtle first taskObj <= hitRange
      [ ask turtles with [ who = first [taskObj] of myself ]
        [ create-hitLink-from myself
          ask hitLinks [ set color black ]
          set healthPoint healthPoint - [attackCap] of myself
          if healthPoint <= 0
          [ ifelse side = 1 [set numOfRedDie numOfRedDie + 1][set numOfBlueDie numOfBlueDie + 1]
            die
          ]
        ]
      ]
    ]
  ]
end

to move
  ;移动规则2（随机侦查）
  ask reconnaissances with [ mobility = 1]
  [
     if side = 1
     [ ifelse not any?  other turtles with [side = 1 and mobility = 1]  in-radius communiRange
       [ set flockingmates other turtles with [side = 3]]
       [ set flockingmates min-n-of 1 other turtles with [side = 1 and mobility = 1 and distance myself < [communiRange] of myself] [ distancexy 150 150 ] ]
     ]
     if side = 2
     [ ifelse not any?  other turtles with [side = 2 and mobility = 1]  in-radius communiRange
       [ set flockingmates other turtles with [side = 3]]
       [ set flockingmates min-n-of 1 other turtles with [side = 2 and mobility = 1 and distance myself < [communiRange] of myself] [ distancexy 50 50] ]
     ];viewdistance) ;; 获得所有viewdistance距离内的所有的其它鸟（靠近邻居）
     set colisionmates (other turtles with  [side = [side] of myself and breed = reconnaissances ] in-radius communiRange ) ;collisiondistance) ;; 获得所有collisiondistance距离内的所有的其它鸟（分离邻居）

     flocking  ;; 根据Boid的三条规则，计算所有的力并更新速度
     facexy xcor + (first velocity) ycor + (last velocity)  ;; 设定鸟的朝向为其速度矢量
     ifelse xcor + (first velocity) >= max-pxcor or xcor + (first velocity) <= min-pxcor or ycor + (last velocity) >= max-pycor or ycor + (last velocity) <= min-pycor
     [ if patch-at dx 0 = nobody [ set heading (- heading)  ]
       if patch-at 0 dy = nobody [ set heading  (180 - heading)  ]
       fd  maxSpeed
     ]
     [ setxy xcor + (first velocity)  ycor + (last velocity) ] ;; 设定下一时刻的位置
     if side = 1 [ set redNum redNum + 1]
     if side = 2 [ set blueNum blueNum + 1]
  ]

  ask commands with [ mobility = 1]
  [
    set flockingmates other turtles with [side = [side] of myself and breed = reconnaissances ] in-radius communiRange ;viewdistance) ;; 获得所有viewdistance距离内的所有的其它鸟（靠近邻居）
    set colisionmates other turtles with [side = [side] of myself and breed = commands] in-radius communiRange ;collisiondistance) ;; 获得所有collisiondistance距离内的所有的其它鸟（分离邻居）
    flocking  ;; 根据Boid的三条规则，计算所有的力并更新速度
    facexy xcor + (first velocity) ycor + (last velocity)  ;; 设定鸟的朝向为其速度矢量
    ifelse xcor + (first velocity) >= max-pxcor or xcor + (first velocity) <= min-pxcor or ycor + (last velocity) >= max-pycor or ycor + (last velocity) <= min-pycor
    [ if patch-at dx 0 = nobody [ set heading (- heading) ]
      if patch-at 0 dy = nobody [ set heading (180 - heading) ]
      fd  maxSpeed
    ]
    [ setxy xcor + (first velocity) ycor + (last velocity) ] ;; 设定下一时刻的位置
    if side = 1 [ set redNum redNum + 1]
    if side = 2 [ set blueNum blueNum + 1]
  ]

  ask hittings with [ mobility = 1]
  [ ifelse empty? taskObj
    [
       set flockingmates other turtles with [side = [side] of myself and breed = commands] in-radius communiRange
       set colisionmates other turtles with [side = [side] of myself and breed = hittings] in-radius communiRange
       flocking  ;; 根据Boid的三条规则，计算所有的力并更新速度
       facexy xcor + ( first velocity) ycor + (last velocity)  ;; 设定鸟的朝向为其速度矢量
       ifelse xcor + (first velocity) >= max-pxcor or xcor + (first velocity) <= min-pxcor or ycor + (last velocity) >= max-pycor or ycor + (last velocity) <= min-pycor
       [ if patch-at dx 0 = nobody [ set heading (- heading) ]
        if patch-at 0 dy = nobody [ set heading (180 - heading)]
        fd random-float maxSpeed
       ]
       [ setxy xcor + (first velocity) ycor + (last velocity) ] ;; 设定下一时刻的位置
    ]
    [
      ifelse any? turtles with [ who = first [taskObj] of myself]
      [
        face turtle first taskObj
        fd maxSpeed
      ]
      [
       set flockingmates other turtles with [side = [side] of myself and breed = commands] in-radius communiRange
       set colisionmates other turtles with [side = [side] of myself and breed = hittings] in-radius communiRange
       flocking  ;; 根据Boid的三条规则，计算所有的力并更新速度
       facexy xcor + ( first velocity) ycor + (last velocity)  ;; 设定鸟的朝向为其速度矢量
       ifelse xcor + (first velocity) >= max-pxcor or xcor + (first velocity) <= min-pxcor or ycor + (last velocity) >= max-pycor or ycor + (last velocity) <= min-pycor
       [ if patch-at dx 0 = nobody [ set heading (- heading) ]
        if patch-at 0 dy = nobody [ set heading (180 - heading)]
        fd random-float maxSpeed
       ]
       [ setxy xcor + (first velocity) ycor + (last velocity) ] ;; 设定下一时刻的位置
      ]
    ]
    if side = 1 [ set redNum redNum + 1]
    if side = 2 [ set blueNum blueNum + 1]
  ]
end
;吸引力和排斥力计算
to flocking
  let corr [0 0] ;; 我所有邻居的平均位置
  let v [0 0] ;; 我所有邻居的平均速度
  let cn count flockingmates ;; 我邻居的数量
  ask flockingmates[
    set corr (map + corr (list xcor ycor)) ;; corr=corr + <xcor, ycor>
    set v (map + v velocity) ;; v= v + velocity
  ]
  if cn > 0[
    set corr (map [ ?1 -> ?1 / cn ] corr) ;; 在corr中的每个元素都除以cn
    set v (map [ ?1 -> ?1 / cn ] v) ;; 在v中的每个元素都除以cn
  ]
  let dis (map - corr (list xcor ycor)) ; dis = corr - <xcor, ycor>, 从我的位置到我邻居们的平均位置的矢量

  set cn count colisionmates ;; 和我可能碰撞的邻居数量
  let cdis [0 0] ;; 和我可能碰撞的邻居们的平均位置（分离邻居的重心位置）
  if cn > 0[
    let ccorr [0 0]
    ask colisionmates[
      set ccorr (map + ccorr (list xcor ycor)) ;; 对<xcor,ycor>求和
    ]

    set ccorr (map [ ?1 -> ?1 / cn ] ccorr) ;; 获得我的分离邻居的平均位置
    set cdis (map - (list xcor ycor) ccorr) ;; 从我的位置指向ccorr位置的矢量
    set cdis (map [ ?1 -> ?1 / ((norm cdis) * (norm cdis) + 0.001) ] cdis) ;; 对矢量做归一化，norm v是计算v的模长
  ]



  ;;加权平均计算合力
  let w1 0.008 ; weight_cohesion
  let w2 0.05 ;weight_alignment
  let w3 6; weight_collision
  let f1 (map [ ?1 -> ?1 * w1 ] dis) ; f1 = w1*<dis_x, dis_y>=<w1*dis_x, w2*dis_y>
  let f2 (map [ ?1 -> ?1 * w2 ] v) ; f2 = w2*v=<w2*v_x,w2*v_y>
  let f3 (map [ ?1 -> ?1 * w3 ] cdis) ; f3=w3*cdis=<w3*cdis_x,w3*cdis_y>
  let force (map [ [?1 ?2 ?3] -> ?1 + ?2 + ?3 ] f1 f2 f3) ;force=f1+f2+f3=<f1_x,f1_y>+<f2_x,f2_y>+<f3_x,f3_y>=<f1_x+f2_x+f3_x,f1_y+f2_y+f3_y>

  ;;根据欧拉法计算新的速度
  set velocity (map + velocity force) ;velocity=velocity+force

  ;;为了避免速度可能变得非常大，我们限定最大的速率为5
  if (norm velocity) > maxSpeed [
    set velocity normalize velocity ;;对速度矢量做归一化，以使得|velocity|=1
    set velocity map [ ?1 -> ?1 * maxSpeed ] velocity ;;velocity = velocity * 5
  ]
end

to-report normalize [xy]
  ;;对输入的矢量xy做归一化，并输出=xy/|xy|
  let realdis norm xy
  let out [0 0]
  if realdis > 0[
    set out (map [ ?1 -> ?1 / realdis ] xy)
  ]
  report out
end
to-report norm [arr]
  ;; 计算输入矢量的模长 |<x,y>|=sqrt(x^2+y^2)
  let xx first arr
  let yy last arr
  report sqrt (xx * xx + yy * yy)
end

to start-recorder
  carefully [ vid:start-recorder ] [ user-message error-message ]
end
to reset-recorder
 vid:reset-recorder
end
to save-recording
  if vid:recorder-status = "inactive" [
    user-message "The recorder is inactive. There is nothing to save."
    stop
  ]
  ; prompt user for movie location
  user-message (word
    "Choose a name for your movie file (the "
    ".mp4 extension will be automatically added).")
  let path user-new-file
  if not is-string? path [ stop ]  ; stop if user canceled
  ; export the movie
  carefully [
    vid:save-recording path
    user-message (word "Exported movie to " path ".")
  ] [
    user-message error-message
  ]
end


to get_Weizhi
  let temp  [];
  ask turtles with [mobility = 1]
  [ set temp sentence iterate temp
    set temp sentence side temp
    set temp sentence xcor  temp
    set temp sentence ycor temp
  ]

  set weiZhiList sentence temp weiZhiList
end

to display_hot_region
  ask patches [
    if redNum != 0
    [ set pcolor 19 - redNum / 20 ]
    if blueNum != 0
    [ set pcolor 109 - blueNum / 20]
    display
  ]
end

to pen
  ask turtles with [ breed = reconnaissances and side = 1]
  [ set-current-plot-pen "blue"
    pen-down
  ]
  ask turtles with [ breed = commands and side = 1]
  [ set-current-plot-pen "blue"
    pen-down
  ]
  ask turtles with [ breed = hittings and side = 1]
  [ set-current-plot-pen "blue"
    pen-down
  ]
  ask turtles with [ breed = reconnaissances and side = 2]
  [ set-current-plot-pen "blue"
    pen-down
  ]
  ask turtles with [ breed = commands and side = 2]
  [ set-current-plot-pen "blue"
    pen-down
  ]
  ask turtles with [ breed = hittings and side = 2]
  [ set-current-plot-pen "blue"
    pen-down
  ]
end
@#$#@#$#@
GRAPHICS-WINDOW
326
13
937
625
-1
-1
3.0
1
10
1
1
1
0
0
0
1
0
200
0
200
0
0
1
ticks
30.0

BUTTON
54
18
136
52
Setup
setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
138
17
219
51
Start
go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
0

PLOT
966
13
1439
303
Current amounts of agents
Iteration
Amount
0.0
10.0
0.0
10.0
true
true
"" ""
PENS
"Red" 1.0 0 -2674135 true "set-current-plot-pen \"redNodes\"" "set-current-plot-pen \"Red\""
"Blue" 1.0 0 -13345367 true "set-current-plot-pen \"blueNodes\"" "set-current-plot-pen \"Blue\""

BUTTON
224
18
304
52
Go-once
go
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
0

PLOT
966
302
1439
615
Current amounts of destroyed agents
Iteration
Amount
0.0
10.0
0.0
10.0
true
true
"" ""
PENS
"Red" 1.0 0 -2674135 true "" "set-current-plot-pen \"Red\""
"Blue" 1.0 0 -13345367 true "" "set-current-plot-pen \"Blue\""

BUTTON
1640
565
1727
598
保存录像
save-recording
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
1638
522
1725
555
开始录像
start-recorder
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
1640
606
1728
640
重置录像
reset-recorder
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
89
120
262
153
recRangeRed
recRangeRed
0
100
100.0
10
1
Km
HORIZONTAL

SLIDER
89
151
262
184
recNumLimitRed
recNumLimitRed
0
10
10.0
1
1
NIL
HORIZONTAL

SLIDER
89
198
264
231
communiRangeRed
communiRangeRed
0
100
60.0
10
1
Km
HORIZONTAL

SLIDER
89
274
262
307
hitRangeRed
hitRangeRed
0
100
70.0
10
1
Km
HORIZONTAL

SLIDER
89
230
262
263
communiNumLimitRed
communiNumLimitRed
0
10
10.0
1
1
NIL
HORIZONTAL

SLIDER
89
305
262
338
hitNumLimitRed
hitNumLimitRed
0
10
10.0
1
1
NIL
HORIZONTAL

SLIDER
90
392
263
425
recRangeBlue
recRangeBlue
0
100
80.0
10
1
Km
HORIZONTAL

SLIDER
90
425
263
458
recNumLimitBlue
recNumLimitBlue
0
10
10.0
1
1
NIL
HORIZONTAL

SLIDER
89
470
262
503
communiRangeBlue
communiRangeBlue
0
100
70.0
10
1
Km
HORIZONTAL

SLIDER
89
501
262
534
communiNumLimitBlue
communiNumLimitBlue
0
10
10.0
1
1
NIL
HORIZONTAL

SLIDER
90
545
263
578
hitRangeBlue
hitRangeBlue
0
100
60.0
10
1
Km
HORIZONTAL

SLIDER
90
578
263
611
hitNumLimitBlue
hitNumLimitBlue
0
10
10.0
1
1
NIL
HORIZONTAL

TEXTBOX
76
98
299
117
Parameter controler of Red camp
12
15.0
0

TEXTBOX
75
372
301
391
Parameter controler of Blue camp
12
105.0
1

BUTTON
121
710
242
743
NIL
clear-drawing
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
79
673
276
706
NIL
pen
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
104
749
260
782
NIL
display_hot_region
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

MONITOR
1647
286
1709
331
iterate
iterate
17
1
11

MONITOR
1648
338
1737
383
recRangeRed
recRangeRed
17
1
11

@#$#@#$#@
## WHAT IS IT?

(a general understanding of what the model is trying to show or explain)

## HOW IT WORKS

(what rules the agents use to create the overall behavior of the model)

## HOW TO USE IT

(how to use the model, including a description of each of the items in the Interface tab)

## THINGS TO NOTICE

(suggested things for the user to notice while running the model)

## THINGS TO TRY

(suggested things for the user to try to do (move sliders, switches, etc.) with the model)

## EXTENDING THE MODEL

(suggested things to add or change in the Code tab to make the model more complicated, detailed, accurate, etc.)

## NETLOGO FEATURES

(interesting or unusual features of NetLogo that the model uses, particularly in the Code tab; or where workarounds were needed for missing features)

## RELATED MODELS

(models in the NetLogo Models Library and elsewhere which are of related interest)

## CREDITS AND REFERENCES

(a reference to the model's URL on the web if it has one, as well as any other necessary credits, citations, and links)
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

command
false
0
Circle -7500403 false true 45 45 210
Polygon -7500403 true true 96 225 150 60 206 224 63 120 236 120
Polygon -7500403 true true 120 120 195 120 180 180 180 185 113 183

commandbase
false
1
Polygon -2674135 true true 0 150 75 30 225 30 300 150 225 270 75 270
Line -1184463 false 195 75 105 75
Line -1184463 false 105 75 75 105
Line -1184463 false 75 105 75 195
Line -1184463 false 75 195 105 225
Line -1184463 false 105 225 195 225

intbase
false
1
Polygon -2674135 true true 0 150 75 30 225 30 300 150 225 270 75 270
Line -1184463 false 105 75 105 240
Line -1184463 false 105 75 180 75
Line -1184463 false 180 75 195 90
Line -1184463 false 195 90 195 135
Line -1184463 false 195 135 180 150
Line -1184463 false 105 150 180 150
Line -1184463 false 120 150 195 240

intelligent
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

strike
true
0
Rectangle -7500403 true true 144 0 159 105
Rectangle -6459832 true false 195 45 255 255
Rectangle -16777216 false false 195 45 255 255
Rectangle -6459832 true false 45 45 105 255
Rectangle -16777216 false false 45 45 105 255
Line -16777216 false 45 75 255 75
Line -16777216 false 45 105 255 105
Line -16777216 false 45 60 255 60
Line -16777216 false 45 240 255 240
Line -16777216 false 45 225 255 225
Line -16777216 false 45 195 255 195
Line -16777216 false 45 150 255 150
Polygon -7500403 true true 90 60 60 90 60 240 120 255 180 255 240 240 240 90 210 60
Rectangle -16777216 false false 135 105 165 120
Polygon -16777216 false false 135 120 105 135 101 181 120 225 149 234 180 225 199 182 195 135 165 120
Polygon -16777216 false false 240 90 210 60 211 246 240 240
Polygon -16777216 false false 60 90 90 60 89 246 60 240
Polygon -16777216 false false 89 247 116 254 183 255 211 246 211 237 89 236
Rectangle -16777216 false false 90 60 210 90
Rectangle -16777216 false false 143 0 158 105

strikebase
false
1
Polygon -2674135 true true 0 150 75 30 225 30 300 150 225 270 75 270
Line -1184463 false 105 60 105 225
Line -1184463 false 105 135 180 135
Line -1184463 false 180 60 180 225
@#$#@#$#@
NetLogo 6.1.1
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180

link2
0.0
-0.2 0 0.0 1.0
0.0 1 4.0 4.0
0.2 0 0.0 1.0
link direction
true
1
Polygon -2674135 true true 150 0 45 255 150 150 255 255
@#$#@#$#@
0
@#$#@#$#@
