import React,{Fragment, useState,useEffect} from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'
import axios from 'axios'
import "./style.css"

const zeropadding = (i) => {
  if (String(i).length < 2) {
    return "0" + i;
  }
  return i;
}; //表示用に0を追加する関数

const CountUpTimer = () => {
  const [time, setTime] = useState({
    hour: 0,
    minute: 0,
    second: 0,
    total: 0
  }); //設定時間

  const [changing, setChanging] = useState(false); //時間が設定されたか
  const [left, setLeft] = useState(0); //残り時間
  const [counting, setCounting] = useState(false); //カウントダウンの判断
  const [switching,setSwitching] = useState(null); //clearTimeoutで処理を止める

  const changeTimerHour = (e) => {
    const value = e.target.value;
    const replaced = value.replace(/^0+/,'') //valueの先頭0を正規表現で削除
    setTime({
      ...time, 
      hour:parseInt(replaced,10)||0
    })
  }

  const changeTimerMinute = (e) => {
    const value = e.target.value;
    const replaced = value.replace(/^0+/,'')
    setTime({
      ...time, 
      minute:parseInt(replaced,10)||0
    })
  }

  const submitData = (t) => { // axiosでRailsにデータを送信
    return axios.post("https://localhost3000/profiles",{
      study_time: t 
    }).then(res=>{
      return res.data
    }).catch((e) => {throw e;})
  }

  useEffect(() => {
    const newtimeHour = Math.floor(time.hour * (60 * 60))
    const newtimeMinute = Math.floor(time.minute * 60)
    const total = newtimeHour + newtimeMinute
    setTime({...time, total: total})
    setLeft(total)
  },[changing])

  useEffect(() => {
    if (!counting) {
      return;
    }
    const id = setTimeout(()=> {
      setLeft( left - 1 );
    }, 1000)
    setSwitching(id)
  },[left,counting])

  // leftに格納された秒数をそれぞれ時・分・秒に変換
  const hour = Math.floor(left / (60 * 60))
  const minute = Math.floor((left - hour * (60 * 60)) / 60 )
  const second = Math.floor(left - hour * (60 * 60) - minute * 60);

  
  return(
    <Fragment>
      <div class="front">
        <p>{zeropadding(hour)}:{zeropadding(minute)}:{zeropadding(second)}</p>
      </div>
      <input type="text" value={time.hour} onChange={changeTimerHour}></input>
      <input type="text" value={time.minute} onChange={changeTimerMinute}></input>
      <button onClick={() => {
        setChanging(!changing)
      }}>時間を設定</button>
      <button onClick={() => {
        setCounting(!counting);

        if (counting) {
          clearTimeout(switching);
          setSwitching(null);
          const totalStudy = time.total - left
          console.log(totalStudy);
          submitData(totalStudy);
        }
      }}>{counting ? "勉強中断" : "勉強開始"}</button>
      {/* <button onClick={}>勉強を終了する</button> */}
  </Fragment>
  )
}

// CountUpTimer.defaultProps = {
//   name: 'Daiki'
// }

// CountUpTimer.propTypes = {
//   name: PropTypes.string
// }

export default CountUpTimer